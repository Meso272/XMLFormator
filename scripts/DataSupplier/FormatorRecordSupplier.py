from ..Adaptor.AdaptorCenter import AdaptorCenter
from ..datamodel.FormatorRecord import FormatorRecord


class FormatorRecordSupplier:
    def __init__(self):
        adaptor = AdaptorCenter().get_adaptor('upload_log')
        self.formated_records = dict()
        sql = 'select md5, thumbnail as thumbnail_path, keyframe as keyframe_path, log_id, xml_formated, ' \
              'json as json_path, json_uploaded from formator_record where xml_formated = 0'
        adaptor.run_sql(sql)
        records = adaptor.fetch_data()
        for row in records:
            record = FormatorRecord(row['md5'], row['thumbnail_path'], row['keyframe_path'], row['log_id'],
                                    row['xml_formated'], row['json_path'], row['json_uploaded'])
            self.formated_records[record.log_id] = record

    def get_formator_records(self):
        return self.formated_records