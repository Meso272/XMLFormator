import json
import logging
import os
import sys

import MySQLdb
import couchdb
from _mysql_exceptions import *

"""
功能: 将特定文件夹下的json文件全部导入couchdb
参数: 文件件路径, couchdb服务器地址, couchdb端口
"""
class Importor:
    def __init__(self, server, port, folderPath=''):
        serverUrl = 'http://' + server + ':' + port + '/'
        self.couch = couchdb.Server(url=serverUrl)
        try:
            self.dbvideo = self.couch['video']
            self.dbprogram = self.couch['program']
            self.dbsequence = self.couch['sequence']
            self.dbscene = self.couch['scene']
            self.dbshot = self.couch['shot']
            self.connected = True
        except TimeoutError:
            logging.error("can't connect to couchdb: %s" % serverUrl)
            self.connected = False
        self.folderPath = folderPath

    def importFile(self, json_string, fileClass):  # 将单个文件导入couchdb, filePath为文件路径
        json_file = json.loads(json_string)
        log_id = self.getLogID(json_string)
        couch_id = ""
        parent_id = ""
        try:
            if fileClass.startswith('Video'):
                [couch_id, rev] = self.dbvideo.save(json_file)
                parent_id = couch_id
            elif fileClass.startswith('Program'):
                [couch_id, rev] = self.dbprogram.save(json_file)
                parent_id = couch_id
            elif fileClass.startswith('Sequence'):
                [couch_id, rev] = self.dbsequence.save(json_file)
                parent_id = self.getParentID(json_string)
            elif fileClass.startswith('Scene'):
                [couch_id, rev] = self.dbscene.save(json_file)
                parent_id = self.getParentID(json_string)
            elif fileClass.startswith('Shot'):
                [couch_id, rev] = self.dbshot.save(json_file)
                parent_id = self.getParentID(json_string)
            self.storeIDs(log_id, couch_id, parent_id)
            return True
        except couchdb.http.ResourceConflict:
            logging.error("resource conflict. please check your video id")
            return False

    def storeIDs(self, log_id, couch_id, parent_id):
        host = ConfRepo.getParam('upload_log', 'ip')
        user = ConfRepo.getParam('upload_log', 'user')
        password = ConfRepo.getParam('upload_log', 'password')
        connection = MySQLdb.connect(host=host, user=user, passwd=password)
        sql = "insert into json_couch_ids (log_id, couch_id, parent_id) values (%d, '%s', '%s')" % (log_id, couch_id, parent_id)
        connection.cursor().execute(sql)


    def getParentID(self, json_string):
        json_file = json.loads(json_string)
        return json_file['Metadata']['ParentID']

    def getParentID(self, json_string):
        json_file = json.loads(json_string)
        return json_file['Metadata']['LogID']

    def batchImport(self, json_folder=""):
        if not self.connected:
            logging.error("cann't connect to couchdb server")
            return 1
        if json_folder != "":
            self.folderPath = json_folder
            # print(json_folder)
        files = os.listdir(self.folderPath)
        for filename in files:
            path = os.path.join(self.folderPath, filename)
            if os.path.isfile(path):
                if filename.endswith('json'):
                    fileClass = path.split('/')[-1]
                    with open(path, "r+", encoding='utf-8') as jsonFile:
                        data = json.load(jsonFile)
                        if fileClass.startswith("Program"):
                            id = data["Metadata"]["ParentID"]
                            data["_id"] = id
                        elif fileClass.startswith("Video"):
                            id = data["Metadata"]["VideoID"]
                            data["_id"] = id
                        json_string = json.dumps(data, indent=4, ensure_ascii=False)
                        if not self.importFile(json_string, fileClass):
                            logging.error("failed to upload file: %s" % path)
                            os.unlink(path)
                            return 1
            elif os.path.isdir(path):
                self.batchImport(path)
        return 0

class Uploader:
    def __init__(self, sql_server, user, passwd, sql_db, couch_server, couch_port):
        self.sql_server = sql_server
        self.sql_db = sql_db
        self.couch_server = couch_server
        self.user = user
        self.passwd = passwd
        self.charset = "utf8"
        self.importor = Importor(couch_server, couch_port)

    def run(self):
        try:
            db = MySQLdb.connect(host=self.sql_server, user=self.user, passwd=self.passwd, charset=self.charset, db=self.sql_db)
        except OperationalError:
            logging.error("can't connect to mysql")
            sys.exit(1)
        formator_record_fetch_cursor = db.cursor(MySQLdb.cursors.DictCursor)
        formator_record_insert_cursor = db.cursor()

        sql = "select * from formator_record where json_uploaded=%d" % 0
        formator_record_fetch_cursor.execute(sql)
        formator_record_fetch_cursor.fetchall()
        if formator_record_fetch_cursor.rowcount == 0:
            logging.info("Couch Uploader: There is no record found to upload")
            sys.exit(0)

        for row in formator_record_fetch_cursor:
            id = row["id"]
            json = row["json"]

            if 0 != self.importor.batchImport(json):
                logging.warning("failed to upload json file in %s \n" % json)
                continue

            formator_record_insert_sql = "update formator_record set json_uploaded=1 where id=%d" % int(id)
            formator_record_insert_cursor.execute(formator_record_insert_sql)
            db.commit()
        db.close()


if __name__ == '__main__':
    uploader = Uploader(sql_server='localhost', user='root', passwd='pkulky201', sql_db='upload_log', couch_server="162.105.16.64", couch_port='5984')
    uploader.run()
