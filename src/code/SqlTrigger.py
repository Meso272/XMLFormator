import logging
import os
import shutil
import sys

import MySQLdb
from ConfRepo import ConfRepo
from MediaConvertor import MediaConvertor
from  _mysql_exceptions import *


class SQLTrigger:
    def __init__(self, host, user, passwd, db):
        self.host = host
        self.user = user
        self.passwd = passwd
        self.charset = 'utf8'
        self.db = db

    def run(self):        
        try:
            db = MySQLdb.connect(host=self.host, user=self.user, passwd=self.passwd, charset=self.charset, db=self.db)
        except OperationalError:
            logging.error("can't connect to mysql")
            sys.exit(1)
    
        upload_log_cursor = db.cursor(MySQLdb.cursors.DictCursor)
        formator_record_fetch_cursor = db.cursor(MySQLdb.cursors.DictCursor)
        formator_record_insert_cursor = db.cursor()
    
        attribs = dict()
        confRepo = ConfRepo()
    
        #sql = "select * from upload_log where date(upload_time) = date(date_sub(now(), interval 1 day))" 
        sql = "select * from upload_log"
        upload_log_cursor.execute(sql)
        upload_log_cursor.fetchall()
        if upload_log_cursor.rowcount == 0:
            logging.warning("Sql: There is no upload log record found to process")
            sys.exit(0)
    
        for row in upload_log_cursor:
            attribs.clear()
            log_id = row["log_id"]
            vendor_name = row["vendor_name"]
            upload_time = row["upload_time"]
            uploader_name = row["uploader_name"]
            xml_upload_path = row["xml_upload_path"]
            video_upload_path = row["video_upload_path"]
            video_cut_path = row["video_cut_path"]
            frame_extract_path = row["frame_extract_path"]
            vendor_path = row["vendor_path"]
            video_price = row["video_price"]
            video_copyright = row["video_copyright"]
            xsl_folder = confRepo.getParam("XSL_map", vendor_name)

            xml_trans_path = row["xml_trans_path"]
            video_play_path = row["video_play_path"]
    
            attribs["VideoPath"] = video_upload_path
            attribs["VendorPath"] = vendor_path
            attribs["VendorName"] = vendor_name
            attribs["UploadTime"] = str(upload_time)
            attribs["VideoPlayPath"] = video_play_path
            attribs["Deleted"] = 0
            attribs["LogID"] = log_id
    
            if not os.path.exists(xml_upload_path):
                logging.warning("xml file: %s not found, skip it" % xml_upload_path)
                sys.stdout.flush()
                continue
            if not os.path.exists(video_upload_path):
                logging.warning("video file: %s not found, skip it" % video_upload_path)
                sys.stdout.flush()
                continue
    
            if not os.path.exists(xml_trans_path):
                logging.info("create xml trans path: %s" % xml_trans_path)
                os.makedirs(xml_trans_path)
            else:
                self.removeFolder(xml_trans_path)
    
            formator_record_fetch_sql = "select * from formator_record where log_id=%d" % log_id;
            formator_record_fetch_cursor.execute(formator_record_fetch_sql)

            need_update = False
            if formator_record_fetch_cursor.rowcount == 1:
                row = formator_record_fetch_cursor.fetchone()

                if row["xml_formated"] != 1:
                    print("")
                    need_update = True
                    if row["md5"]:
                        attribs["MD5"] = row["md5"]
                    if row["thumbnail"]:
                        attribs["Thumbnail"] = row["thumbnail"]
                    if row["keyframe"]:
                        attribs["Keyframes"] = row["keyframe"]
                else:
                    continue
    
            media_convertor = MediaConvertor(xml_upload_path, xsl_folder, video_upload_path, xml_trans_path, attribs)

            try:
                result = media_convertor.convert()
            except Exception as e:
                logging.error("SqlTrigger: MediaConvertor convert failed! File: %s" % xml_upload_path)
                print(e)
                print("\n")
                continue

            if result is None:
                logging.error("sqltrigger: can create xml file.")
                continue;
            [MD5, thumbnail_path, keyframes_folder] = result

            json_path = xml_trans_path + '/json'
            formator_record_insert_sql = "insert into formator_record (md5, thumbnail, keyframe, log_id, xml_formated, json, json_uploaded) values ('%s', '%s', '%s', %d, %d, '%s', %d)" % (MD5, thumbnail_path, keyframes_folder, int(log_id), 1, json_path, 0)
            if need_update:
                formator_record_insert_sql = "update formator_record set xml_formated=1 where log_id=%d" % int(log_id)
            formator_record_insert_cursor.execute(formator_record_insert_sql)
            db.commit()

        db.close()

    def removeFolder(self, folder):
        return
        for the_file in os.listdir(folder):
            file_path = os.path.join(folder, the_file)
            try:
                if os.path.isfile(file_path):
                    os.unlink(file_path)
                elif os.path.isdir(file_path):
                    shutil.rmtree(file_path)
            except Exception as e:
                print(e)
