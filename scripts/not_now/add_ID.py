import couchdb, glob, json
import os

def add(filePath):
    fileClass = filePath.split('/')[-1]
    with open(filePath, "r+", encoding='utf-8') as jsonFile:
        data = json.load(jsonFile)
        if fileClass.startswith("Video"):
            tmp = data["Metadata"]["VideoID"]
        else:
            return  
        id = tmp
        data["_id"] = id 
        jsonFile.seek(0)  # rewind
                    
        jsonFile.write(json.dumps(data, indent=4, ensure_ascii=False))
        jsonFile.truncate() 


def batchAdd(folderPath):
    files = os.listdir(folderPath)
    for filename in files:
        path = os.path.join(folderPath, filename)
        if os.path.isfile(path):
            if filename.endswith('json'):
                add(path)
        elif os.path.isdir(path):
            batchAdd(path)


if __name__ == '__main__':
    batchAdd('/home/derc/zhouludong/result')
