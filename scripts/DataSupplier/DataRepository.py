from .FormattedRecordSupplier import FormatterRecordSupplier
from .MaterialSupplier import MaterialSupplier
from .UploadLogSupplier import UploadLogSupplier
from ..Utility.Singleton import Singleton


class DataRepository(metaclass=Singleton):
    def __init__(self):
        self.data = dict()
        self.data['formatter_record'] = FormatterRecordSupplier().get_formatter_records()
        self.data['personal_record'] = MaterialSupplier().get_personal_records()
        self.data['upload_log'] = UploadLogSupplier().get_upload_log()

    def get_data(self, key):
        if key in self.data:
            return self.data[key]
        return None

    def refresh(self):
        self.data['formatter_record'] = FormatterRecordSupplier().get_formatter_records()
        self.data['personal_record'] = MaterialSupplier().get_personal_records()
        self.data['upload_log'] = UploadLogSupplier().get_upload_log()