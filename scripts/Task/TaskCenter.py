import logging
from .CouchdbUploadTask import UploadTask
from .GeneratePersonalTask import GeneratePersonalTask
from .XMLFormatTask import XMLFormatTask


class TaskCenter:
    def __init__(self):
        self.tasks = list()
        logging.info("generating personal xml...")
#        self.tasks.append(GeneratePersonalTask())
        logging.info("formatting xml...")
        self.tasks.append(XMLFormatTask())
        logging.info("uploading json...")
        self.tasks.append(UploadTask())

    def run(self):
        for task in self.tasks:
            task.run()
