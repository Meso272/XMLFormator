import os
import logging
import uuid
from lxml import etree
from ..DataSupplier.DataRepository import DataRepository
from ..Utility.FileUtility import FileUtility
from ..Adaptor.AdaptorCenter import AdaptorCenter


class GeneratePersonalTask:
    def __init__(self):
        self.materials = DataRepository().get_data('personal_record')

    @staticmethod
    def generate_xml(personal_video):
        xml_string = "<?xml version=\"1.0\"?>" \
                     "<Metadata VendorName=\"Personal\" VendorPath=\"N/A\" VideoPath=\"%s\">" \
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
                     (personal_video.video_path, personal_video.title, personal_video.keywords,
                      personal_video.produced_time, personal_video.duration, personal_video.format,
                      personal_video.brief)
        return xml_string

    def run(self):
        logging.info("generating personal xml...")
        upload_insert_sql = "insert into upload_log " \
                            "(vendor_name, upload_time, uploader_name, xml_upload_path, xml_trans_path, " \
                            "video_upload_path, video_cut_path, frame_extract_path, vendor_path, video_price, " \
                            "video_copyright, video_play_path, material_id, video_price_type, " \
                            "video_copyright_duration, material_type) values "
        original_len = len(upload_insert_sql)
        for material_id in self.materials:
            material = self.materials[material_id]
            xml_string = self.generate_xml(material)
            xml_root = etree.fromstring(xml_string)
            xml_string = etree.tostring(xml_root, encoding='UTF-8', pretty_print=True, xml_declaration=True).decode('UTF-8')
            xml_path = os.getcwd() + "/../personal_xml/" + str(uuid.uuid4()).replace('-', '') + '.xml'
            FileUtility().write_file(xml_path, xml_string)

            vendor_name = "Personal"
            xml_trans_path = os.getcwd() + "/../result/" + material.title + '_' + str(material.duration) + '_' + material.format
            video_cut_path = xml_trans_path
            frame_extract_path = xml_trans_path if not material.thumbnail else material.thumbnail

            video_path = material.video_path
            vendor_path = material.vendor_path
            _copyright = material.copyright
            video_play_path = material.video_play_path
            price = material.price if material.price else 1
            upload_insert_sql += "('%s', NOW(), 'Admin', '%s', '%s', '%s', '%s', '%s', '%s', %d, '%s', '%s', %d, %d, %d, '%s')," % \
                                 (vendor_name, xml_path, xml_trans_path, video_path, video_cut_path,
                                  frame_extract_path, vendor_path, price, _copyright, video_play_path,
                                  material_id, material.price_type, material.periods, material.mtype)
            material_update_sql = "update material set xml_formatted = 1 where id=%d;" % material_id
            if material_update_sql:
                AdaptorCenter().get_adaptor('tps').run_sql(material_update_sql)
        FileUtility().write_flush()
        upload_insert_sql = upload_insert_sql[:-1] + ';'
        if len(upload_insert_sql) != original_len:
            AdaptorCenter().get_adaptor('upload_log').run_sql(upload_insert_sql)
        else:
            logging.info("no material records need to update")
