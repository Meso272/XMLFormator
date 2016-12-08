from ..DataModel.UploadLog import Video
from ..Adaptor.AdaptorCenter import AdaptorCenter


class UploadLogSupplier:
    def __init__(self):
        self.records = dict()
        sql = 'select * from upload_log where log_id not in ' \
              '(select log_id from formatter_record where xml_formatted = 1)'
        adaptor = AdaptorCenter().get_adaptor('upload_log')
        adaptor.run_sql(sql)
        self.upload_records = adaptor.fetch_data()
        for row in self.upload_records:
            record = Video(row['log_id'], row['vendor_name'], row['upload_time'], row['uploader_name'],
                           row['xml_upload_path'], row['video_upload_path'], row['video_cut_path'],
                           row['frame_extract_path'], row['vendor_path'], row['video_price'],
                           row['video_copyright'], row['material_id'], row['video_play_path'], row['xml_trans_path'])
            self.records[record.log_id] = record

    def get_upload_log(self):
        return self.records
