from .FormatorRecordSupplier import FormatorRecordSupplier
from .MaterialSupplier import MaterialSupplier
from .UploadLogSupplier import UploadLogSupplier


class DataRepository:
    def __init__(self):
        self.data = dict()
        self.data['formator_record'] = FormatorRecordSupplier().get_formator_records()
        self.data['personal_record'] = MaterialSupplier().get_personal_records()
        self.data['upload_log'] = UploadLogSupplier().get_upload_log()

    def get_data(self, key):
        if key in self.data:
            return self.data[key]
        return None
