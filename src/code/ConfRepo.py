import configparser
import logging


class ConfRepo:
    def __init__(self, confFile="~/media_converting/XMLFormator/src/code/Conf.ini"):
        self.conf = configparser.ConfigParser()
        self.conf.read(confFile, 'utf-8')

    def getParam(self, section, option):
        if section in self.conf.keys() and option in self.conf[section]:
            return self.conf.get(section, option)
        else:
            logging.error("section or option: %s not found in configure file" % (section + ": " + option))
            return False

    def getSections(self):
        return self.conf.keys()


if __name__ == "__main__":
    confFile = "Conf.ini"
    confRepo = ConfRepo(confFile)
    for section in confRepo.getSections():
        if section != "DEFAULT":
            print("%s = %s" % (section, confRepo.getParam(section, "ip")))
