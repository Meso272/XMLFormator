import glob
import logging
import os

from lxml import etree, objectify


class XMLFormator:

    def __init__(self, xml_path, xsl_path, dest_folder, attribs):
        self.xml_path = xml_path
        self.xsl_path = xsl_path
        self.dest_folder = dest_folder

        self.raw_xml = ''
        self.xsls = list()
        self.xml_elements = list()
        self.all_xml = ''
        self.new_xml_elements = list()
        self.ready_to_write = list()
        self.attribs = attribs

        if not os.path.exists(self.dest_folder):
            os.makedirs(self.dest_folder)

        # time to trim
        self.longTime = ["DateofEvent", "DateofAwards", "AuthorizedDateofStart", "AuthorizedDeadline",
                    "ProducedDate", "DateofDebut", "PublishedDate", "ShotingDate", "DateofEnvent"]
        self.shortTime = ["Duration", "StartingPoint"]

    def __get_files__(self):
        if not os.path.isfile(self.xml_path):
            logging.error("XMLFormator. xml file: %s not exists" % self.xml_path)
            return 1

        self.raw_xml = etree.tostring(etree.parse(self.xml_path))

        XSLFiles = glob.glob(self.xsl_path + "/*.xsl")
        if len(XSLFiles) == 0:
            logging.error("XMLFormator. xsl files: %s not exist" % self.xsl_path)
            return 2

        for xsl in XSLFiles:
            self.xsls.append(etree.tostring(etree.parse(xsl)))

    def __add_attributes__(self):
        if not self.all_xml:
            logging.error("XMLFormator. all_xml file not read in")
            return 1

        root = etree.fromstring(self.all_xml)

        if len(self.attribs) == 0:
            logging.warning("XMLFormator. no attribs to add")
            return 0

        for key in self.attribs:
            if key == "MD5":
                continue
            root.set(key, self.attribs[key])
        root.set("VideoID", self.attribs["MD5"])
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
        for tagname in self.ready_to_write:
            for i in range(len(self.ready_to_write[tagname])):
                ele_string = self.ready_to_write[tagname][i]
                xml_file_name = self.dest_folder + "/" + tagname + str(i) + "_" + self.attribs["MD5"] + ".xml"
                with open(xml_file_name, 'w+', encoding='utf-8') as outFile:
                    outFile.write(str(ele_string))

    #获得原始xml的所有子元素,并且将其标准化, 以字符串数组的形式返回
    def __get_xml_elements__(self):
        xmlStrings = list()

        for xsl in self.xsls:
            formatedXML = self.__transform__(xsl)
            if not formatedXML:
                continue
            tempRoot = etree.fromstring(formatedXML)
            if len(tempRoot) == 0:
                continue
            formatedXML = self.__removeEmpty__(formatedXML)
            formatedXML = self.__trimTime__(formatedXML)
            xmlStrings.append(formatedXML)
        if not xmlStrings:
            logging.warning(
                "XMLFormator: there is no xmlString for file: %s, maybe unsupported structure" % self.xml_path)
        return xmlStrings

    def __trimLong__(self, time):
        newDate = ''
        if not time or time == '无':
            return newDate
        newDate = time
        newDate.replace('年', '-')
        newDate.replace('日', '')
        newDate.replace('月', '-')
        if newDate.find(':') == -1:
            newDate += ' 00:00:00'
        return newDate

    def __trimShort__(self, time):
        if not time or time == '无':
            return ''
        if time == "00:00:00":
            time = "0"
        time = int(time) // 25
        hour = time // 3600
        min = (time % 3600) // 60
        second = (time % 3600) % 60
        newDate = str(hour) + ':' + str(min) + ':' + str(second)
        return newDate

    def __trimTime__(self, xml_string):
        root = etree.fromstring(xml_string)
        for time in self.longTime:
            for node in root.iter(time):
                node.text = self.__trimLong__(node.text)
        for time in self.shortTime:
            for node in root.iter(time):
                node.text = self.__trimShort__(node.text)
        return etree.tostring(root, encoding='utf-8', pretty_print=True, xml_declaration=True)

    def __recursively_empty__(self, e):
        if e.text:
            if e.text != '无':
                return False
            return True
        return all((self.__recursively_empty__(c) for c in e.iterchildren()))

    def __removeEmpty__(self, xml_string):
        root = objectify.fromstring(xml_string)
        context = etree.iterwalk(root)

        for action, elem in context:
            parent = elem.getparent()
            if parent is None:
                continue
            if self.__recursively_empty__(elem):
                parent.remove(elem)
        str = etree.tostring(root, encoding='utf-8', pretty_print=True, xml_declaration=True)
        return str

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
            newroot = etree.Element("Metadata")
            for key in root.attrib:
                if key == "VideoID":
                    newroot.set("ParentID", root.attrib[key])
                else:
                    newroot.set(key, root.attrib[key])
            newroot.append(child)
            if child.tag not in visited:
                visited.add(child.tag)
                j = 0
            else:
                j += 1
            string = etree.tostring(newroot, encoding='utf-8', pretty_print=True, xml_declaration=True).decode('utf-8')
            if child.tag in ans:
                ans[child.tag].append(string)
            else:
                ans[child.tag] = [string]

        return ans

    def __transform__(self, xsl_string):
        xslRoot = etree.fromstring(xsl_string)
        transformer = etree.XSLT(xslRoot)
        root = etree.fromstring(self.raw_xml)

        for elem in root.getiterator():
            if not hasattr(elem.tag, 'find'): continue  # (1)
            i = elem.tag.find('}')
            if i >= 0:
                elem.tag = elem.tag[i + 1:]

        objectify.deannotate(root, cleanup_namespaces=True)
        transRoot = transformer(root)
        return etree.tostring(transRoot, encoding='utf-8', pretty_print=True, xml_declaration=True)