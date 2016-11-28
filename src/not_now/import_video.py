import couchdb, glob, json
import os

class Importor:
    def __init__(self, server='192.168.1.106', port='5984'):
        serverUrl = 'http://' + server + ':' + port + '/'
        self.couch = couchdb.Server(url=serverUrl)
        self.dbvideo = self.couch['video']

    def importFile(self, filePath):
        fileClass = filePath.split('/')[-1]
        with open(filePath) as jsonFile:
            string = json.load(jsonFile)
            if fileClass.startswith('Video'):
                self.dbvideo.save(string)

    def batchImport(self, folderPath):
        '''
        jsonFiles = glob.glob(folderPath + '/*.json')
        for jsonFile in jsonFiles:
            print(jsonFile)
            if jsonFile.endswith('json'):
                self.importFile(jsonFile)
        '''
        files = os.listdir(folderPath)
        for filename in files:
            path = os.path.join(folderPath, filename)
            if os.path.isfile(path):
                if filename.endswith('json'):
                    self.importFile(path)
            elif os.path.isdir(path):
                self.batchImport(path)


if __name__ == '__main__':
    importor = Importor()
    importor.batchImport('/home/derc/zhouludong/result')
