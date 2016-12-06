import logging
from scripts.Task.TaskCenter import TaskCenter
from scripts.Utility.Configure import ConfRepo

if __name__ == "__main__":
    logging.basicConfig(level=ConfRepo().get_param('DEFAULT', 'logging_level'))
    #logging.basicConfig(filename='formatter.log', level=ConfRepo().get_param('DEFAULT', 'logging_level'))
    task_center = TaskCenter()
    task_center.run()

