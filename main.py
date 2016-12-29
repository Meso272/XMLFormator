import logging
from scripts.Task.TaskCenter import TaskCenter
from scripts.Utility.Configure import ConfRepo

if __name__ == "__main__":
    logging.basicConfig(format='%(asctime)s. %(levelname)s. %(filename)s:%(lineno)s: %(message)s',
                        filename=ConfRepo().get_param('DEFAULT', 'logging_file'),
                        level=ConfRepo().get_param('DEFAULT', 'logging_level'))

    logging.info("\n")
    task_center = TaskCenter()
    task_center.run()
