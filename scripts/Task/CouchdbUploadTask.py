import json
import logging
import os
import sys
import couchdb
from ..Adaptor.AdaptorCenter import AdaptorCenter
from ..Utility.Configure import ConfRepo

"""
功能: 将特定文件夹下的json文件全部导入couchdb
参数: 文件件路径, couchdb服务器地址, couchdb端口
"""


class UploaderWorker:
    def __init__(self, server, port, folder_path=''):
        server_url = 'http://' + server + ':' + port + '/'
        self.couch = couchdb.Server(url=server_url)
        try:
            self.db_video = self.couch['video']
            self.db_program = self.couch['program']
            self.db_sequence = self.couch['sequence']
            self.db_scene = self.couch['scene']
            self.db_shot = self.couch['shot']
            self.connected = True
        except TimeoutError:
            logging.error("can't connect to couchdb: %s" % server_url)
            self.connected = False
        self.folderPath = folder_path
        self.adaptor = AdaptorCenter().get_adaptor('upload_log')
        self.conf = ConfRepo()
        self.insert_sql = "insert into json_couch_ids (log_id, couch_id, parent_id, couch_rev, material_id, layer) values"

    def import_file(self, json_string, file_class):  # 将单个文件导入couchdb, filePath为文件路径
        json_file = json.loads(json_string)
        log_id = int(self.get_id(json_string, 'LogID'))
        material_id = self.get_id(json_string, 'MaterialID')
        couch_id = ""
        rev = ""
        parent_id = ""
        try:
            layer = ''
            if file_class.startswith('Video'):
                [couch_id, rev] = self.db_video.save(json_file)
                parent_id = couch_id
                layer = 'video'
            elif file_class.startswith('Program'):
                [couch_id, rev] = self.db_program.save(json_file)
                parent_id = self.get_id(json_string, "ParentID")
                layer = 'program'
            elif file_class.startswith('Sequence'):
                [couch_id, rev] = self.db_sequence.save(json_file)
                parent_id = self.get_id(json_string, "ParentID")
                layer = 'sequence'
            elif file_class.startswith('Scene'):
                [couch_id, rev] = self.db_scene.save(json_file)
                parent_id = self.get_id(json_string, "ParentID")
                layer = 'scene'
            elif file_class.startswith('Shot'):
                [couch_id, rev] = self.db_shot.save(json_file)
                parent_id = self.get_id(json_string, "ParentID")
                layer = 'shot'
            self.update_sql(log_id, couch_id, parent_id, rev, material_id, layer)
            return True
        except couchdb.http.ResourceConflict:
            logging.error("resource conflict. please check your video id")
            return False

    def update_sql(self, log_id, couch_id, parent_id, rev, material_id, layer):
        self.insert_sql += "(%d, '%s', '%s', '%s', '%s', '%s')," % (log_id, couch_id, parent_id, rev, material_id, layer)

    def get_id(self, json_string, id_name):
        json_file = json.loads(json_string)
        return json_file['Metadata'][id_name]

    def batch_import(self, json_folder=""):
        if not self.connected:
            logging.error("can't connect to couchdb server")
            return 1
        if json_folder != "":
            self.folderPath = json_folder
            # print(json_folder)
        files = os.listdir(self.folderPath)
        for filename in files:
            path = os.path.join(self.folderPath, filename)
            if os.path.isfile(path) and filename.endswith('json'):
                file_class = path.split('/')[-1]
                with open(path, "r+", encoding='utf-8') as jsonFile:
                    data = json.load(jsonFile)
                    # if file_class.startswith("Program"):
                    #     _id = data["Metadata"]["ParentID"]
                    #     data["_id"] = _id
                    if file_class.startswith("Video"):
                        _id = data["Metadata"]["VideoID"]
                        data["_id"] = _id
                    json_string = json.dumps(data, indent=4, ensure_ascii=False)
                    if not self.import_file(json_string, file_class):
                        logging.error("failed to upload file: %s" % path)
                        os.unlink(path)
                        return 1
            elif os.path.isdir(path):
                self.batch_import(path)
        self.insert_sql = self.insert_sql[:-1] + ';'
        self.adaptor.run_sql(self.insert_sql)
        self.insert_sql = "insert into json_couch_ids (log_id, couch_id, parent_id, couch_rev, material_id, layer) values"
        return 0


class UploadTask:
    def __init__(self):
        couch_server = ConfRepo().get_param('couchdb', 'ip')
        couch_port = ConfRepo().get_param('couchdb', 'port')
        self.adaptor = AdaptorCenter().get_adaptor('upload_log')

        self.importer = UploaderWorker(couch_server, couch_port)

    def run(self):
        logging.info("Uploading json file...")
        cursor = self.adaptor.cursor

        sql = "select * from formatter_record where json_uploaded=%d" % 0
        self.adaptor.run_sql(sql)
        formatter_records = self.adaptor.fetch_data()
        if cursor.rowcount == 0:
            logging.info("There is no record found to upload")
            sys.exit(0)

        update_sql = ''
        for record in formatter_records:
            _id = record['id']
            json_content = record['json']

            if 0 != self.importer.batch_import(json_content):
                logging.warning("failed to upload json file in %s" % json_content)
                continue

            update_sql = "update formatter_record set json_uploaded=1 where id=%d;" % int(_id)
            self.adaptor.run_sql(update_sql)

