import couchdb, json, os, logging


"""
功能: 将特定文件夹下的json文件全部导入couchdb
参数: 文件件路径, couchdb服务器地址, couchdb端口
"""
class Importor:
    def __init__(self, server='192.168.1.106', port='5984', folderPath=''):
        serverUrl = 'http://' + server + ':' + port + '/'
        self.couch = couchdb.Server(url=serverUrl)
        try:
            self.dbvideo = self.couch['video']
            self.dbprogram = self.couch['program']
            self.dbsequence = self.couch['sequence']
            self.dbscene = self.couch['scene']
            self.dbshot = self.couch['shot']
            self.connected = True
        except TimeoutError:
            logging.error("can't connect to couchdb: %s" % serverUrl)
            self.connected = False
        self.folderPath = folderPath

    def importFile(self, json_string, fileClass):  # 将单个文件导入couchdb, filePath为文件路径
        if fileClass.startswith('Video'):
            self.dbvideo.save(json_string)
        elif fileClass.startswith('Program'):
            self.dbprogram.save(json_string)
        elif fileClass.startswith('Sequence'):
            self.dbsequence.save(json_string)
        elif fileClass.startswith('Scene'):
            self.dbscene.save(json_string)
        elif fileClass.startswith('Shot'):
            self.dbshot.save(json_string)

    def batchImport(self):
        if not self.connected:
            return 1
        files = os.listdir(self.folderPath)
        for filename in files:
            path = os.path.join(self.folderPath, filename)
            if os.path.isfile(path):
                if filename.endswith('json'):
                    fileClass = path.split('/')[-1]
                    with open(path, "r+", encoding='utf-8') as jsonFile:
                        data = json.load(jsonFile)
                        if fileClass.startswith("Program"):
                            id = data["Metadata"]["ParentID"]
                            data["_id"] = id
                        elif fileClass.startswith("Video"):
                            id = data["Metadata"]["VideoID"]
                            data["_id"] = id
                        json_string = json.dumps(data, indent=4, ensure_ascii=False)
                        self.importFile(json_string, fileClass)
            elif os.path.isdir(path):
                self.batchImport(path)
        return 0


if __name__ == '__main__':
    importor = Importor()
    importor.batchImport('/home/derc/media_converting/result')
