import logging
from scripts.Task.TaskCenter import TaskCenter
from scripts.Utility.Configure import ConfRepo

if __name__ == "__main__":
    logging.info("\n")
    logging.basicConfig(filename=ConfRepo().get_param('DEFAULT', 'logging_file'),
                        level=ConfRepo().get_param('DEFAULT', 'logging_level'),
                        format='%(asctime)s: %(levelname)s: %(message)s')
    task_center = TaskCenter()
    task_center.run()
