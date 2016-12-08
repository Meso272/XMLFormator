import configparser
import logging
import os
from .Singleton import Singleton


class ConfRepo(metaclass=Singleton):
    def __init__(self, conf_file="Conf.ini"):
        self.conf = configparser.ConfigParser()
        if not os.path.isfile(conf_file):
            logging.error("configure file not found. please give a connect path")
        result = self.conf.read(conf_file, 'utf-8')
        if result is None:
            logging.error("configure file not found. please give a connect path")
            exit(1)

    def get_param(self, section, option):
        if section in self.conf.keys() and option in self.conf[section]:
            return self.conf.get(section, option)
        else:
            logging.error("section or option: %s not found in configure file" % (section + ": " + option))
            return False

    # def get_param(self, option):
    #     if option in self.conf.default_section:
    #         return self.conf.default_section[option]
    #     else:
    #         logging.error("option: %s not found in default section" % (option))
    #         return False

    def get_sections(self):
        return self.conf.keys()

