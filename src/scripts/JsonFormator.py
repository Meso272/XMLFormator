import subprocess #用来执行jar文件


class JSONFormator:
    # json_path 是一个文件夹, 递归的遍历json_path 所代表的文件夹, 将发现的json 格式化一下
    def format(self, json_path):
        subprocess.call(['java', '-jar', 'JsonValidation.jar', json_path])


if __name__ == "__main__":
    json_formator = JSONFormator()
    json_formator.format("../../unittest/result/json")
