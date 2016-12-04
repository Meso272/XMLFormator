from ..Adaptor.AdaptorCenter import AdaptorCenter
from ..datamodel.PersonalVideo import PersonalVideo
from ..utility.StringUtility import StringUtility
import cv2


class MaterialSupplier:
    def __init__(self):
        adaptor = AdaptorCenter().get_adaptor('tps')
        self.personal_records = dict()
        sql = 'select id, title, lowdef_video_upload_path as video_path, video_tag as keywords,' \
              'bDate as produced_time, duration, format as video_format, brief_info as brief from material' \
              'where status = 1 and xml_formated = 0'
        adaptor.run_sql(sql)
        self.personal_records = adaptor.fetch_data()
        for row in self.personal_records:
            record = PersonalVideo(row['id'], StringUtility.trim_title(row['title']), row['video_path'], row['keywords'], row['produced_time'],
                                   self.get_video_duration(row['video_path']), row['video_format'], row['brief'])
            self.personal_records[record.material_id] = record

    def get_personal_records(self):
        return self.personal_records

    def get_video_duration(self, file_path):
        cap = cv2.VideoCapture(file_path)
        return int(cap.get(cv2.CAP_PROP_FRAME_COUNT))
