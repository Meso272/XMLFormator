import datetime
import logging
import sys

import MySQLdb
from _mysql_exceptions import *
from lxml import etree


class PersonalXMLGenerator:
    def __init__(self, host, user, passwd, db):
        self.host = host
        self.user = user
        self.passwd = passwd
        self.db = db
        self.charset = "utf8"

    def generate(self):
        try:
            db = MySQLdb.connect(host=self.host, user=self.user, passwd=self.passwd, charset=self.charset, db=self.db)
            upload_log_db = MySQLdb.connect(host=self.host, user=self.user, passwd=self.passwd, charset=self.charset,
                                            db="upload_log")
        except OperationalError:
            logging.error("can't connect to mysql")
            sys.exit(1)

        personal_upload_info_fetcher = db.cursor(MySQLdb.cursors.DictCursor)
        personal_upload_insertor = db.cursor()
        personal_xml_insertor = upload_log_db.cursor()

        upload_info_sql = "select * from material where status=0"
        personal_upload_info_fetcher.execute(upload_info_sql)
        personal_upload_info_fetcher.fetchall()

        if personal_upload_info_fetcher.rowcount == 0:
            logging.warning("Personal: There is no upload log record found to process")
            return

        for row in personal_upload_info_fetcher:
            id = row["id"]
            title = row["title"]
            video_path = row["lowdef_video_upload_path"]
            vendor_path = row["highdef_video_upload_path"]
            keywords = row["video_tag"]
            produced_time = row["bDate"]
            hours = row["hours"]
            minutes = row["minutes"]
            seconds = row["seconds"]

            duration = (int(hours) * 3600 + int(minutes) * 60 + seconds) * 25
            copyright = row["copyright"]
            mtype = row["mType"]
            format = row["format"]
            brief = row["brief_info"]
            price = row["price"]
            if price == None:
                price = 1
            xml_formated = row["status"]
            video_play_path = row["file_uri"]

            """if title contains slash"""
            title = title.replace("/", "-")
            title = title.replace("<", "")

            xml_string = "<?xml version='1.0'?>" \
                         "<Metadata VendorName='Personal' VendorPath='N/A' VideoPath='%s'>" \
                         "<Program>" \
                         "<Title><ProperTitle>%s</ProperTitle></Title>" \
                         "<Subject>" \
                         "<Keyword>%s</Keyword>" \
                         "</Subject>" \
                         "<Date>" \
                         "<ProducedDate>%s</ProducedDate>" \
                         "</Date>" \
                         "<Format>" \
                         "<StartingPoint>00:00:00</StartingPoint>" \
                         "<Duration>%s</Duration>" \
                         "<FileFormat>%s</FileFormat>" \
                         "</Format>" \
                         "<Description>" \
                         "<DescriptionofContent>%s</DescriptionofContent>" \
                         "</Description>" \
                         "</Program></Metadata>" % (video_path, title, keywords, produced_time, duration, format, brief)
            xml_root = etree.fromstring(xml_string.encode("utf-8"))
            xml_string = etree.tostring(xml_root, encoding='utf-8', pretty_print=True, xml_declaration=True)
            title = title.replace(' ', '_')
            xml_path = "/home/luyj/media_converting/personal_xml/"+title+'_'+str(duration)+'.xml'
            with open(xml_path, 'w+', encoding='utf-8') as outFile:
                outFile.write(xml_string.decode("utf-8"))

            vendor_name = "Personal"
            a = datetime.datetime.now()
            xml_trans_path = "/home/luyj/media_converting/result/" + title+'_'+str(duration)+'_'+format
            video_cut_path = xml_trans_path
            frame_extract_path = xml_trans_path

            insert_sql = "insert into upload_log (vendor_name, upload_time, uploader_name, xml_upload_path," \
                         " xml_trans_path, video_upload_path, video_cut_path, frame_extract_path, vendor_path," \
                         " video_price, video_copyright, video_play_path) values ('%s', NOW(), 'Admin', '%s', '%s', '%s', '%s', '%s', '%s', %d, '%s', '%s')" % (vendor_name, xml_path, xml_trans_path, video_path, video_cut_path, frame_extract_path, vendor_path, price, copyright, video_play_path)
            update_sql = "update material set status=1 where id=%d" % id
            personal_xml_insertor.execute(insert_sql)
            personal_upload_insertor.execute(update_sql)
            upload_log_db.commit()
            db.commit()

        upload_log_db.commit()
        db.close()

if __name__ == "__main__":
    generator = PersonalXMLGenerator("localhost", "root", "pkulky201", "tps")
    generator.generate()
