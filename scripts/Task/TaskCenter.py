from .CouchdbUploadTask import UploadTask
from .GeneratePersonalTask import GeneratePersonalTask
from .XMLFormatTask import XMLFormatTask


class TaskCenter:
    def __init__(self):
        self.tasks = list()
        self.tasks.append(GeneratePersonalTask())
        self.tasks.append(XMLFormatTask())
        self.tasks.append(UploadTask())

    def run(self):
        for task in self.tasks:
            task.run()
