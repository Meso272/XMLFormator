from ..Adaptor.AdaptorCenter import AdaptorCenter
from ..DataModel.PersonalVideo import PersonalVideo
from ..Utility.StringUtility import StringUtility
import cv2


class MaterialSupplier:
    def __init__(self):
        adaptor = AdaptorCenter().get_adaptor('tps')
        self.personal_records = dict()
        sql = 'select id, title, file_uri as video_path, highdef_video_upload_path as vendor_path, ' \
              'video_tag as keywords, bDate as produced_time, hours, minutes, seconds, copyright, mtype, format, ' \
              'brief_info, price, xml_formatted, pricing_type, thumbnail, duration, periods ' \
              'from material where on_shelf = 1 and xml_formatted = 0;'
        adaptor.run_sql(sql)
        self.records = adaptor.fetch_data()
        if self.records is None:
            return
        for row in self.records:
            record = PersonalVideo(row['id'], StringUtility.trim_title(row['title']), row['video_path'],
                                   row['vendor_path'], row['keywords'], row['produced_time'], row['hours'],
                                   row['minutes'], row['seconds'], row['copyright'], row['mtype'],
                                   row['format'], row['brief_info'], row['price'], row['xml_formatted'],
                                   row['video_path'], row['pricing_type'], row['thumbnail'], row['duration'],
                                   row['periods'])
            self.personal_records[record.material_id] = record

    def get_personal_records(self):
        return self.personal_records
