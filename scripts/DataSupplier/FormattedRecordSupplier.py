from ..Adaptor.AdaptorCenter import AdaptorCenter
from ..DataModel.FormatterRecord import FormatterRecord


class FormatterRecordSupplier:
    def __init__(self):
        adaptor = AdaptorCenter().get_adaptor('upload_log')
        self.formatted_records = dict()
        sql = 'select id, md5, thumbnail as thumbnail_path, keyframe as keyframe_path, log_id, xml_formatted, ' \
              'json as json_path, json_uploaded from formatter_record where xml_formatted = 0;'
        adaptor.run_sql(sql)
        records = adaptor.fetch_data()
        for row in records:
            record = FormatterRecord(row['id'], row['md5'], row['thumbnail_path'], row['keyframe_path'], row['log_id'],
                                     row['xml_formatted'], row['json_path'], row['json_uploaded'])
            self.formatted_records[record.log_id] = record

    def get_formatter_records(self):
        return self.formatted_records
