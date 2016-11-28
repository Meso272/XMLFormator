import configparser
import logging
import os


class ConfRepo:
    def __init__(self, conf_file="../Conf.ini"):
        os.chdir(os.path.dirname(__file__))
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

    def get_sections(self):
        return self.conf.keys()

