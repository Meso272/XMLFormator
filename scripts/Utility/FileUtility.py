from .Singleton import Singleton
import os
import logging


class FileUtility(metaclass=Singleton):
    def __init__(self):
        self.buffer = dict()

    def write_file(self, path, content):
        # print(content)
        self.buffer[path] = content

    @staticmethod
    def read_file(path):
        if not os.path.exists(path):
            logging.error('file not exists: %s' % path)
            return None
        with open(path, 'r', encoding='utf-8') as f:
            content = f.read()
        return content

    def write_flush(self):
        for path in self.buffer:
            if not os.path.exists('/'.join(path.split('/')[:-1])):
                logging.warning('path not exists: %s' % path)
                os.mkdir(path='/'.join(path.split('/')[:-1]))
            content = self.buffer[path]
            # print(content)
            with open(path, 'w+', encoding='utf-8') as f:
                f.write(content)
        self.buffer.clear()

    @staticmethod
    def rm_files_in_dir(folder):
        for the_file in os.listdir(folder):
            file_path = os.path.join(folder, the_file)
            try:
                if os.path.isfile(file_path):
                    os.unlink(file_path)
                    # elif os.path.isdir(file_path): shutil.rmtree(file_path)
            except Exception as e:
                print(e)
