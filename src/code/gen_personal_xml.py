import MySQLdb, logging, sys, time, datetime
from _mysql_exceptions import *
from lxml import etree

class PersonalXMLGenerator:
    def __init__(self, host="192.168.1.106", user="root", passwd="pkulky201", db="tps"):
        self.host = host
        self.user = user
        self.passwd = passwd
        self.db = db
        self.charset = "utf8"

    def generate(self):
        try:
            db = MySQLdb.connect(host=self.host, user=self.user, passwd=self.passwd, charset=self.charset, db=self.db)
        except OperationalError:
            logging.error("can't connect to mysql")
            sys.exit(1)

        personal_upload_info_fetcher = db.cursor(MySQLdb.cursors.DictCursor)
        personal_upload_insertor = db.cursor()
        personal_xml_insertor = db.cursor()

        upload_info_sql = "select * from upload_media_info where xml_formated=0"
        personal_upload_info_fetcher.execute(upload_info_sql)
        personal_upload_info_fetcher.fetchall()

        if personal_upload_info_fetcher.rowcount == 0:
            logging.warning("There is no upload log record found to process")
            sys.exit(0)

        for row in personal_upload_info_fetcher:
            id = row["id"]
            title = row["title"]
            video_path = row["lowdef_vedio_upload_path"]
            vendor_path = row["highdef_vedio_upload_path"]
            keywords = row["video_tag"]
            produced_time = row["bDate"]
            duration = row["duration"]
            copyright = row["copyright"]
            mtype = row["mType"]
            format = row["format"]
            brief = row["brief_info"]
            price = row["price"]
            xml_formated = row["xml_formated"]

            xml_string = "<?xml version='1.0' encoding='utf-8'?>" \
                         "<Metadata VendorName='Personal' VendorPath='N/A VideoPath='%s'>" \
                         "<Program>" \
                         "<Title><ProperTitle>%s</ProperTitle>" \
                         "<Subject>" \
                         "<Keyword>%s</Keyword>" \
                         "</Subject>" \
                         "<Date>" \
                         "<ProducedDate>%s</ProducedDate>" \
                         "</Date>" \
                         "<Format>" \
                         "<Duration>%s</Duration>" \
                         "<FileFormat>%s</FileFormat>" \
                         "</Format>" \
                         "<Description>" \
                         "<DescriptionofContent>%s</DescriptionofContent>" \
                         "</Description>" \
                         "</Program></Metadata>" % (video_path, title, keywords, produced_time, duration, format, brief)
            xml_root = etree.fromstring(xml_string)
            xml_string = etree.tostring(xml_root, encoding='utf-8', pretty_print=True, xml_declaration=True)
            continue
            xml_path = "/home/derc/media_converting/personal_xml/"+title+'_'+duration+'.'+format
            with open(xml_path, 'w+', encoding='utf-8') as outFile:
                outFile.write(xml_string)

            vendor_name = "Personal"
            a = datetime.datetime.now()
            xml_trans_path = "/home/derc/media_converting/result/" + title+'_'+duration+'_'+format
            video_cut_path = xml_trans_path
            frame_extract_path = xml_trans_path

            insert_sql = "insert into upload_log (vendor_name, upload_time, uploader_name, xml_upload_path," \
                         " xml_trans_path, video_upload_path, video_cut_path, frame_extract_path, vendor_path," \
                         " video_price, video_copyright) values ('%s', NOW(), 'Admin', '%s', '%s', '%s', '%s', '%s', '%s', %d, '%s')" % (vendor_name, xml_path, xml_trans_path, video_path, video_cut_path, frame_extract_path, vendor_path, price, copyright)
            update_sql = "update upload_media_info set xml_formated=1 where id=%d" % id
            print(insert_sql, '\n', update_sql)
            continue

            personal_upload_insertor.execute(update_sql)
            personal_xml_insertor.execute(insert_sql)
            db.commit()

        db.close()

if __name__ == "__main__":
    generator = PersonalXMLGenerator()
    generator.generate()
