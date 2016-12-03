import os
import lxml.etree as ET

for filename in os.listdir("/home/derc/xml"):
    root = ET.parse(open(os.path.join("/home/derc/xml", filename))).getroot()
    newname = root[1][1].text + '.xml'
    os.rename(os.path.join("/home/derc/xml",filename), os.path.join("/home/derc/xml",newname))
