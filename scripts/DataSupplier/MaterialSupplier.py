from ..Adaptor.AdaptorCenter import AdaptorCenter
from ..DataModel.PersonalVideo import PersonalVideo
from ..Utility.StringUtility import StringUtility
import cv2


class MaterialSupplier:
    def __init__(self):
        adaptor = AdaptorCenter().get_adaptor('tps')
        self.personal_records = dict()
        sql = 'select id, title, lowdef_video_upload_path as video_path, highdef_video_upload_path as vendor_path, video_tag as keywords,' \
              'bDate as produced_time, hours, minutes, seconds, copyright, mtype, format, brief_info, price, xml_formatted from material ' \
              'where status = 1 and xml_formatted = 0;'
        adaptor.run_sql(sql)
        self.records = adaptor.fetch_data()
        for row in self.records:
            record = PersonalVideo(row['id'], StringUtility.trim_title(row['title']), row['video_path'],
                                   row['vendor_path'], row['keywords'], row['produced_time'], row['hours'],
                                   row['minutes'], row['seconds'], row['copyright'], row['mtype'],
                                   row['format'], row['brief_info'], row['price'], row['xml_formatted'], row['video_path'])
            self.personal_records[record.material_id] = record

    def get_personal_records(self):
        return self.personal_records
