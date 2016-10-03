from VideoAttribExtractor import VideoAttribExtractor
from XML2JSON import xml2Json
from XMLFormator import XMLFormator


class MediaConvertor:
    def __init__(self, xml_path, xsl_folder, video_path, dest_folder, attribs):
        self.xml_path = xml_path
        self.xsl_folder = xsl_folder
        self.video_path = video_path
        self.dest_folder = dest_folder
        self.attribs = attribs

    def convert(self):
        if "MD5" not in self.attribs:
            thumbnail_folder = self.dest_folder + '/thumbnail'
            keyframes_folder = self.dest_folder + '/keyframes'
            video_attrib_extractor = VideoAttribExtractor(self.video_path, thumbnail_folder, keyframes_folder)

            [MD5, thumbnail_path, keyframes_folder] = video_attrib_extractor.extract()
            self.attribs["MD5"] = MD5
            self.attribs["Thumbnail"] = thumbnail_path
            self.attribs["Keyframes"] = keyframes_folder

        xml_formator = XMLFormator(self.xml_path, self.xsl_folder, self.dest_folder + "/xml", self.attribs)
        xml_formator.format()

        xml_to_json = xml2Json()
        xml_to_json.batchTransform(self.dest_folder + "/xml", self.dest_folder+"/json")

        return [self.attribs["MD5"], self.attribs["Thumbnail"], self.attribs["Keyframes"]]

