from ..datamodel.UploadLog import Video
from ..Adaptor.AdaptorCenter import AdaptorCenter


class UploadLogSupplier:
    def __init__(self):
        self.upload_records = dict()
        sql = 'select log_id, vendor_name, upload_time, xml_upload_path, video_upload_path, ' \
              'frame_extract_path, vendor_path, material_id, xml_trans_path, video_play_path' \
              'from upload_log where xml_formated = 0'
        adaptor = AdaptorCenter().get_adaptor('upload_log')
        adaptor.run_sql(sql)
        self.upload_records = adaptor.fetch_data()
        for row in self.upload_records:
            record = Video(row['log_id'], row['vendor_name'], row['upload_time'], row['xml_upload_path'],
                           row['video_upload_path'], row['frame_extract_path'], row['vendor_path'], row['material_id'],
                           row['xml_trans_path'], row['video_play_path'])
            self.upload_records[record.log_id] = record

    def get_upload_log(self):
        return self.upload_records
