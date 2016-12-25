import glob
import json
import logging
import os
import xmltodict
from ..Utility.FileUtility import FileUtility
from ..Formatter.JsonFormatter import JSONFormatter


class XML2Json:
    @staticmethod
    def xml2json(xml_path, dest_path, xml_attribs=True):
        with open(xml_path, "rb") as f:  # notice the "rb" mode
            d = xmltodict.parse(f, xml_attribs=xml_attribs, encoding='utf-8', attr_prefix='')
            if not d:
                logging.error("xmltodict failed for file: %s. Exit" % xml_path)
                return 1

            string = json.dumps(d, indent=4, ensure_ascii=False)
            if not string:
                logging.error("json dumps failed for file: %s. Exit" % xml_path)
                return 2

            with open(dest_path, 'w+', encoding='utf-8') as outFile:
                outFile.write(string)
            return 0

    # 将一个文件夹下的xml文件转成json文件, 不会递归的遍历文件夹, 只是在顶层目录查找
    def batch_transform(self, xml_folder, json_folder):
        if not os.path.exists(json_folder):
            os.makedirs(json_folder)
            logging.info("Create jsonFolder: %s" % json_folder)

        xml_files = glob.glob(xml_folder + "/*.xml")
        if len(xml_files) == 0:
            logging.warning("can't find any xml file in %s to transform. Exit" % xml_folder)
            return 0
        FileUtility().rm_files_in_dir(json_folder)
        for xml_file in xml_files:
            dst_path = json_folder + '/' + xml_file.split('/')[-1][:-4] + '.json'
            self.xml2json(xml_file, dst_path)

        json_formatter = JSONFormatter()
        return json_formatter.format(json_folder)
