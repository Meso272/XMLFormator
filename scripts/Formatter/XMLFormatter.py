import glob
import logging
import os
from lxml import etree, objectify
from ..Utility.FileUtility import FileUtility
from datetime import datetime, date, time

class XMLFormatter:

    def __init__(self, xml_path, xsl_path, dest_folder, attribs):
        self.xml_path = xml_path
        self.xsl_path = xsl_path
        self.dst_folder = dest_folder

        self.raw_xml = ''
        self.xsls = list()
        self.xml_elements = list()
        self.all_xml = ''
        self.new_xml_elements = list()
        self.ready_to_write = list()
        self.attribs = attribs

        if not os.path.exists(self.dst_folder):
            os.makedirs(self.dst_folder)

        # time to trim
        self.longTime = ["DateofEvent", "DateofAwards", "AuthorizedDateofStart", "AuthorizedDeadline",
                    "ProducedDate", "DateofDebut", "PublishedDate", "ShotingDate", "DateofEnvent"]
        self.shortTime = ["Duration", "StartingPoint"]

    def __get_files__(self):
        if not os.path.isfile(self.xml_path):
            logging.error("xml file: %s not exists" % self.xml_path)
            return 1

        try:
            self.raw_xml = etree.tostring(etree.parse(self.xml_path), encoding='unicode')
        except:
            logging.error("xml file not supported: %s" % self.xml_path)
            self.raw_xml = ''
            return 3

        XSLFiles = glob.glob(self.xsl_path + "/*.xsl")
        if len(XSLFiles) == 0:
            logging.error("xsl files: %s not exist" % self.xsl_path)
            return 2

        for xsl in XSLFiles:
            self.xsls.append(etree.tostring(etree.parse(xsl)))

    def __add_attributes__(self):
        if not self.all_xml:
            logging.error("all_xml file not read in")
            return 1

        root = etree.fromstring(self.all_xml)

        if len(self.attribs) == 0:
            logging.warning("no attribs to add")
            return 0

        for key in self.attribs:
            if key == "MD5":
                continue
            root.set(key, str(self.attribs[key]))
        root.set("VideoID", str(self.attribs["MD5"]))
        new_all_string = etree.tostring(root, encoding='utf-8', pretty_print=True, xml_declaration=True)
        self.all_xml = new_all_string.decode("utf-8")
        return 0

    def format(self):
        if self.__get_files__():
            return 1

        self.xml_elements = self.__get_xml_elements__()
        if len(self.xml_elements) == 0:
            return 2

        self.all_xml = self.__combineXML__()
        if len(self.all_xml) == 0:
            return 3

        if self.__add_attributes__():
            return 4

        self.new_xml_elements = self.__split_xml__()
        self.ready_to_write = self.new_xml_elements
        self.ready_to_write["Video"] = [self.all_xml]
        self.__write_xml__()

        return 0

    def __write_xml__(self):
        FileUtility().rm_files_in_dir(self.dst_folder)
        for tag_name in self.ready_to_write:
            for i in range(len(self.ready_to_write[tag_name])):
                ele_string = self.ready_to_write[tag_name][i]
                xml_file_name = self.dst_folder + "/" + tag_name + str(i) + "_" + self.attribs["MD5"] + ".xml"
                with open(xml_file_name, 'w+', encoding='utf-8') as outFile:
                    outFile.write(str(ele_string))

    # 获得原始xml的所有子元素,并且将其标准化, 以字符串数组的形式返回
    def __get_xml_elements__(self):
        xml_strings = list()

        for xsl in self.xsls:
            formatted_xml = self.__transform__(xsl)
            if not formatted_xml:
                continue
            temp_root = etree.fromstring(formatted_xml)
            if len(temp_root) == 0:
                continue
            formatted_xml = self.remove_empty(formatted_xml)
            formatted_xml = self.trim_time(formatted_xml)
            xml_strings.append(formatted_xml)
        if not xml_strings:
            logging.warning( "there is no xmlString for file: %s, maybe unsupported structure" % self.xml_path)
        return xml_strings

    @staticmethod
    def trim_long(time):
        if time:
            time = time.replace('年', '-')
            time = time.replace('月', '-')
            time = time.replace('日', '')
        try:
            dt = datetime.strptime(time, "%Y/%m/%d %H:%M:%S")
            return dt.isoformat(' ')
        except ValueError:
            new_date = ''
            if not time or time == '无':
                return new_date
            new_date = time
            new_date.replace('年', '-')
            new_date.replace('日', '')
            new_date.replace('月', '-')
            if new_date.find(':') == -1:
                new_date += ' 00:00:00'
            new_date = new_date.replace('/', '-')
            return new_date

    @staticmethod
    def trim_short(time):
        if not time or time == '无':
            return ''
        if time == "00:00:00":
            time = "0"
        try:
            time = int(float(time))
        except :
            time = 0
        hours = time // 3600
        minutes = (time % 3600) // 60
        seconds = (time % 3600) % 60
        new_date = str(hours) + ':' + str(minutes) + ':' + str(seconds)
        return new_date

    def trim_time(self, xml_string):
        root = etree.fromstring(xml_string)
        for time in self.longTime:
            for node in root.iter(time):
                node.text = self.trim_long(node.text)
        for time in self.shortTime:
            for node in root.iter(time):
                node.text = self.trim_short(node.text)
        return etree.tostring(root, encoding='utf-8', pretty_print=True, xml_declaration=True)

    def recursively_empty(self, e):
        if e.text:
            if e.text != '无':
                return False
            return True
        return all((self.recursively_empty(c) for c in e.iterchildren()))

    def remove_empty(self, xml_string):
        root = objectify.fromstring(xml_string)
        context = etree.iterwalk(root)

        for action, elem in context:
            parent = elem.getparent()
            if parent is None:
                continue
            if self.recursively_empty(elem):
                parent.remove(elem)
        content = etree.tostring(root, encoding='utf-8', pretty_print=True, xml_declaration=True)
        return content

    def __combineXML__(self):
        ans = '<Metadata>\n'
        for xml_file in self.xml_elements:
            data = etree.fromstring(xml_file)

            for child in data:
                string = etree.tostring(child, encoding='utf-8')
                ans += string.decode("utf-8")
        ans += '</Metadata>'
        return ans

    def __split_xml__(self):
        root = etree.fromstring(self.all_xml.encode("utf-8"))

        j = 0
        visited = set()
        ans = dict()

        for child in root:
            new_root = etree.Element("Metadata")
            for key in root.attrib:
                if key == "VideoID":
                    new_root.set("ParentID", root.attrib[key])
                else:
                    new_root.set(key, root.attrib[key])
            new_root.append(child)
            if child.tag not in visited:
                visited.add(child.tag)
                j = 0
            else:
                j += 1
            string = etree.tostring(new_root, encoding='utf-8', pretty_print=True, xml_declaration=True).decode('utf-8')
            if child.tag in ans:
                ans[child.tag].append(string)
            else:
                ans[child.tag] = [string]

        return ans

    def __transform__(self, xsl_string):
        xsl_root = etree.fromstring(xsl_string)
        transformer = etree.XSLT(xsl_root)
        utf8_parser = etree.XMLParser(encoding='utf-8')
        root = etree.fromstring(self.raw_xml.encode('utf-8'), parser=utf8_parser)

        for elem in root.getiterator():
            if not hasattr(elem.tag, 'find'): continue  # (1)
            i = elem.tag.find('}')
            if i >= 0:
                elem.tag = elem.tag[i + 1:]

        objectify.deannotate(root, cleanup_namespaces=True)
        transRoot = transformer(root)
        return etree.tostring(transRoot, encoding='utf-8', pretty_print=True, xml_declaration=True)