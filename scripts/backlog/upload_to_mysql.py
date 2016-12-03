import MySQLdb, glob, os
from os import listdir
from os.path import isfile, join
from formator import Formator


db = MySQLdb.connect(host="localhost", user="root", passwd="", db="upload_log")
cursor = db.cursor()

folder = "/Volumes/Seagate Expansion Drive/数据/节目-第2批/低码/"

for dir in listdir(folder):
    for name in listdir(folder + dir):
        files = listdir(folder + dir + '/' + name)
        xmlFile = ''
        videoFile = ''
        for file in files:
            if file.endswith('.xml'):
                xmlFile = '/home/derc/xml/' + file
            elif file.endswith('.wmv'):
                videoFile = '/home/derc/video/' + file
        query = "insert into upload_log (xml_upload_path, video_upload_path, vendor_name," \
                " vendor_path) values ( '%s', '%s', '%s', '%s')" % \
                (xmlFile, videoFile, 'BTV', 'NA')
        #print(query)
        cursor.run_sql(query)
db.commit()
db.close()