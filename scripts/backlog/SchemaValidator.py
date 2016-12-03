from os import listdir
from os.path import isfile, join
from lxml import etree


class Validator:
    def __init__(self, xsd_source):
        self.xsd_file = open(xsd_source, 'r')
        self.xmlschema_doc = etree.parse(self.xsd_file)
        self.xmlschema = etree.XMLSchema(self.xmlschema_doc)

    def validate(self, xml):
        doc = etree.parse(open(xml, 'r', encoding='utf-8'))
        self.xmlschema.assertValid(doc)

if __name__ == '__main__':
    validator = Validator('schema.xsd')
    xml_folder = './xml4validate'
    xml_names = [f for f in listdir(xml_folder) if isfile(join(xml_folder, f))]
    for xml_name in xml_names:
        xml_path = xml_folder+'/'+xml_name
        validator.validate(xml_path)
