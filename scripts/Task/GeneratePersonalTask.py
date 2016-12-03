import datetime
import logging
import sys
import os
import MySQLdb
import cv2
from _mysql_exceptions import *
from lxml import etree
from scripts.supplier import MaterialSupplier


class PersonalXMLGenerator:
    def __init__(self, host, user, passwd, db):
        self.material_supplier = MaterialSupplier(host, user, passwd, db)
        self.materials = self.material_supplier.get_material()
        self.material_connection = MySQLdb.connect(host=host, user=user, passwd=passwd, charset='utf8', db=db)
        self.uploadlog_connection = MySQLdb.connect(host=host, user=user, passwd=passwd, charset='utf8', db='upload_log')

    def trim_title(self, title):
        title = title.replace("/", "-")
        title = title.replace("<", "")
        title = title.replace(" ", "_")
        return title

    def generate_xml(self, row):
        title = row["title"]
        video_path = row["lowdef_video_upload_path"]
        keywords = row["video_tag"]
        produced_time = row["bDate"]
        duration = row["duration"]
        video_format = row["format"]
        brief = row["brief_info"]
        title = self.trim_title(title)

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
                     "<StartingPoint>0</StartingPoint>" \
                     "<Duration>%s</Duration>" \
                     "<FileFormat>%s</FileFormat>" \
                     "</Format>" \
                     "<Description>" \
                     "<DescriptionofContent>%s</DescriptionofContent>" \
                     "</Description>" \
                     "</Program></Metadata>" %\
                     (video_path, title, keywords, produced_time, duration, video_format, brief)
        return xml_string

    def write_file(self, path, string):
        with open(path, 'w+', encoding='utf-8') as outFile:
            outFile.write(string.decode("utf-8"))

    def execute(self, sql, connection):
        connection.cursor().run_sql(sql)
        connection.commit()

    def generate(self):
        insert_sql = ""
        update_sql = ""
        for row in self.materials:
            duration = self.getVideoDuration(row["lowdef_video_upload_path"])
            row['duration'] = duration

            xml_string = self.generate_xml(row)
            xml_root = etree.fromstring(xml_string.encode("utf-8"))
            xml_string = etree.tostring(xml_root, encoding='utf-8', pretty_print=True, xml_declaration=True)
            title = row["title"]
            xml_path = os.getcwd() + "/../../../personal_xml/" + title + '_' + str(row["duration"]) + '.xml'
            self.write_file(xml_path, xml_string)

            vendor_name = "Personal"
            xml_trans_path = os.getcwd() + "/../../../result/" + title+'_'+str(duration)+'_'+format
            video_cut_path = xml_trans_path
            frame_extract_path = xml_trans_path

            video_path = row["lowdef_video_upload_path"]
            vendor_path = row["highdef_video_upload_path"]
            copyright = row["copyright"]
            video_play_path = row["file_uri"]
            price = row["price"] if row["price"] else 1
            material_id = row["id"]
            insert_sql += "insert into upload_log (vendor_name, upload_time, uploader_name, xml_upload_path," \
                         " xml_trans_path, video_upload_path, video_cut_path, frame_extract_path, vendor_path," \
                         " video_price, video_copyright, video_play_path, material_id) values " \
                         "('%s', NOW(), 'Admin', '%s', '%s', '%s', '%s', '%s', '%s', %d, '%s', '%s', %d);" % \
                         (vendor_name, xml_path, xml_trans_path, video_path, video_cut_path, frame_extract_path,
                          vendor_path, price, copyright, video_play_path, material_id)
            update_sql += "update material set xml_formated=1 where id=%d;" % material_id
        self.execute(insert_sql, self.uploadlog_connection)
        self.execute(update_sql, self.material_connection)

    def getVideoDuration(self, filePath):
        cap = cv2.VideoCapture(filePath)
        return int(cap.get(cv2.CAP_PROP_FRAME_COUNT))

if __name__ == "__main__":
    generator = PersonalXMLGenerator("localhost", "root", "pkulky201", "tps")
    generator.generate()
