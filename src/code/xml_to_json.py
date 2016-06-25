import xmltodict, json, glob, os, logging
from json_formator import JSONFormator

class xml2Json:
    def xml2json(self, xmlPath, destPath, xml_attribs=True):
        with open(xmlPath, "rb") as f:  # notice the "rb" mode
            d = xmltodict.parse(f, xml_attribs=xml_attribs, encoding='utf-8', attr_prefix='')
            if not d:
                logging.error("xml2Json. xmltodict failed for file: %s. Exit" % xmlPath)
                return 1

            string = json.dumps(d, indent=4, ensure_ascii=False)
            if not string:
                logging.error("xml2Json. json dumps failed for file: %s. Exit" % xmlPath)
                return 2

            with open(destPath, 'w+', encoding='utf-8') as outFile:
                outFile.write(string)
            return 0

    # 将一个文件夹下的xml文件转成json文件, 不会递归的遍历文件夹, 只是在顶层目录查找
    def batchTransform(self, xmlFolder, jsonFolder):
        if not os.path.exists(jsonFolder):
            os.makedirs(jsonFolder)
            logging.warning("xml2Json. jsonFolder not exist. The Path is %s, instead I create it\n" % jsonFolder)

        xml_files = glob.glob(xmlFolder + "/*.xml")
        if len(xml_files) == 0:
            logging.warning("xml2Json. can't find any xml file to transform. Exit\n")
            return 0

        for xml_file in xml_files:
            destPath = jsonFolder + '/' + xml_file.split('/')[-1][:-4] + '.json'
            self.xml2json(xml_file, destPath)

        json_formator = JSONFormator()
        json_formator.format(jsonFolder)
