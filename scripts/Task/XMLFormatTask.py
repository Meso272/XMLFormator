import logging
import uuid
import os

from ..Formatter.XML2JSON import XML2Json
from ..Formatter.XMLFormatter import XMLFormatter
from ..VideoExtractor.VideoAttribExtractor import VideoAttribExtractor
from ..DataSupplier.DataRepository import DataRepository
from ..Utility.Configure import ConfRepo
from ..Adaptor.AdaptorCenter import AdaptorCenter


class XMLFormatTask:
    def __init__(self):
        DataRepository().refresh()
        self.upload_records = DataRepository().get_data('upload_log')
        self.formatter_records = DataRepository().get_data('formatter_record')

    def run(self):
        DataRepository().refresh()
        self.upload_records = DataRepository().get_data('upload_log')
        self.formatter_records = DataRepository().get_data('formatter_record')
        insert_sql = "insert into formatter_record " \
                     "(md5, thumbnail, keyframe, log_id, xml_formatted, json, json_uploaded) values "
        update_sql = ''
        # upload_log_sql = ''
        for record_id in self.upload_records:
            record = self.upload_records[record_id]
            if not os.path.isfile(record.xml_upload_path):
                logging.error("xml file not found, log_id = %d, path = '%s'" %
                              (record.log_id, record.xml_upload_path))
                continue
            if not os.path.isfile(record.video_upload_path):
                logging.error("video file not found, log_id = %d, path = '%s'" %
                              (record.log_id, record.video_upload_path))
                continue

            need_update = False
            attribs2add = dict()
            attribs2add["VideoPath"] = record.video_upload_path
            attribs2add["VendorPath"] = record.vendor_path
            attribs2add["VendorName"] = record.vendor_name
            attribs2add["UploadTime"] = str(record.upload_time)
            attribs2add["VideoPlayPath"] = record.video_play_path
            attribs2add["Visible"] = 1
            attribs2add["LogID"] = record.log_id
            attribs2add["MaterialID"] = record.material_id
            md5 = ''
            thumbnail_path = ''
            keyframes_path = ''
            if record.log_id in self.formatter_records:
                formatter_record = self.formatter_records[record.log_id]
                need_update = True
                [md5, thumbnail_path, keyframes_path] = \
                    [formatter_record.md5, formatter_record.thumbnail_path, formatter_record.keyframe_path]
            else:
                thumbnail_path = record.xml_trans_path + '/thumbnail'
                keyframes_path = record.xml_trans_path + '/keyframes'
                video_attrib_extractor = VideoAttribExtractor(record.video_upload_path, thumbnail_path, keyframes_path)
                [_, thumbnail_path, keyframes_path] = video_attrib_extractor.extract()
                # use uuid instead of md5
                uuid_string = str(uuid.uuid4()).replace('-', '')
                md5 = uuid_string
            predefined_thumbnail = self.get_predefined_thumbnail(record.frame_extract_path) if record.frame_extract_path else None
            thumbnail_path = predefined_thumbnail if predefined_thumbnail else thumbnail_path

            attribs2add['MD5'] = md5
            attribs2add['Thumbnail'] = thumbnail_path
            attribs2add['Keyframes'] = keyframes_path

            json_path = record.xml_trans_path + '/json'
            xml_path = record.xml_trans_path + '/xml'
            xsl_folder = ConfRepo().get_param("XSL_map", record.vendor_name)
            xml_formatter = XMLFormatter(record.xml_upload_path, xsl_folder, xml_path, attribs2add)
            if xml_formatter.format() != 0:
                logging.error("Mediaconvertor: can not generate xml file, please check all path are right.")
                return None

            xml_to_json = XML2Json()
            if not xml_to_json.batch_transform(xml_path, json_path):
                logging.error("json verification failed: %s" % json_path)
                continue

            if not need_update:
                insert_sql += "('%s', '%s', '%s', %d, %d, '%s', %d)," % \
                              (md5, thumbnail_path, keyframes_path, int(record.log_id), 1, json_path, 0)
            else:
                update_sql += "update formatter_record set xml_formatted=1 where log_id=%d;" % int(record.log_id)
        insert_sql = insert_sql[:-1] + ';'
        AdaptorCenter().get_adaptor('upload_log').run_sql(insert_sql)
        AdaptorCenter().get_adaptor('upload_log').run_sql(update_sql)

    @staticmethod
    def get_predefined_thumbnail(path):
        if os.path.isfile(path):
            return path
        for the_file in sorted(os.listdir(path)):
            thumbnail_path = os.path.join(path, the_file)
            if os.path.isfile(thumbnail_path) and (the_file.endswith(".jpg") or the_file.endswith(".jpeg")):
                return thumbnail_path
        return None
