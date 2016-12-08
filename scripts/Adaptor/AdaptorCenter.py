from .Adaptor import Adaptor
from ..Utility.Configure import ConfRepo
from ..Utility.Singleton import Singleton


class AdaptorCenter(metaclass=Singleton):
    def __init__(self):
        self.adaptors = dict()
        upload_log_adaptor = Adaptor(ConfRepo().get_param('upload_log', 'ip'),
                                     ConfRepo().get_param('upload_log', 'user'),
                                     ConfRepo().get_param('upload_log', 'password'),
                                     ConfRepo().get_param('upload_log', 'db')
                                     )
        tps_adaptor = Adaptor(ConfRepo().get_param('tps', 'ip'),
                              ConfRepo().get_param('tps', 'user'),
                              ConfRepo().get_param('tps', 'password'),
                              ConfRepo().get_param('tps', 'db')
                              )
        self.adaptors['upload_log'] = upload_log_adaptor
        self.adaptors['tps'] = tps_adaptor

    def get_adaptor(self, name):
        if name in self.adaptors:
            return self.adaptors[name]
        else:
            return None
