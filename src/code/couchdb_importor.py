import couchdb, glob, json
import os


"""
功能: 将特定文件夹下的json文件全部导入couchdb
参数: 文件件路径, couchdb服务器地址, couchdb端口
"""
class Importor:
    def __init__(self, server='192.168.1.106', port='5984', folderPath=''):
        serverUrl = 'http://' + server + ':' + port + '/'
        self.couch = couchdb.Server(url=serverUrl)
        self.dbvideo = self.couch['video']
        self.dbprogram = self.couch['program']
        self.dbsequence = self.couch['sequence']
        self.dbscene = self.couch['scene']
        self.dbshot = self.couch['shot']
        self.folderPath = folderPath

    def importFile(self, filePath):  # 将单个文件导入couchdb, filePath为文件路径
        fileClass = filePath.split('/')[-1]
        with open(filePath) as jsonFile:
            string = json.load(jsonFile)
            if fileClass.startswith('Video'):
                _id = string["Metadata"]["VideoID"]
                self.dbvideo.save(string, )
            elif fileClass.startswith('Program'):
                self.dbprogram.save(string)
            elif fileClass.startswith('Sequence'):
                self.dbsequence.save(string)
            elif fileClass.startswith('Scene'):
                self.dbscene.save(string)
            elif fileClass.startswith('Shot'):
                self.dbshot.save(string)

    def batchImport(self):
        files = os.listdir(self.folderPath)
        for filename in files:
            path = os.path.join(self.folderPath, filename)
            if os.path.isfile(path):
                if filename.endswith('json'):
                    self.importFile(path)
            elif os.path.isdir(path):
                self.batchImport(path)


if __name__ == '__main__':
    importor = Importor()
    importor.batchImport('/home/derc/zhouludong/result')
