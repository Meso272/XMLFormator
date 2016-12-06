class FormatterRecord:
    def __init__(self, id, md5, thumbnail_path, keyframe_path, log_id, xml_formatted, json_path, json_uploaded):
        self.id = id
        self.md5 = md5
        self.thumbnail_path = thumbnail_path
        self.keyframe_path = keyframe_path
        self.log_id = log_id
        self.xml_formatted = xml_formatted
        self.json_path = json_path
        self.json_uploaded = json_uploaded
