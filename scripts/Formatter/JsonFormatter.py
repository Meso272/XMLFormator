import subprocess #用来执行jar文件


class JSONFormatter:
    # json_path 是一个文件夹, 递归的遍历json_path 所代表的文件夹, 将发现的json 格式化一下
    @staticmethod
    def format(json_path):
        subprocess.call(['java', '-jar', 'JsonValidation.jar', json_path])
