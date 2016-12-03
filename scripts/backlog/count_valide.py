import MySQLdb, glob, os

if __name__ == '__main__':
    db = MySQLdb.connect(host="localhost", user="root", passwd="pkulky201", charset='utf8', db="myupload_log")
    cursor = db.cursor()
    sql = "select * from upload_log"
    cursor.run_sql(sql)
    results = cursor.fetchall()
    valide = 0
    for i in range(len(results)):
        row = results[i]
        srcXMLPath = row[0]
        srcXSLFolder = '/home/derc/zhouludong/src/xsl/BTV'
        destXMLFolder = '/home/derc/zhouludong/result/result' + str(i)
        videoPath = row[1]
        HDPath = row[3]
        vendor = row[2]
        if not os.path.exists(srcXMLPath):
            print('xml file not found: ', srcXMLPath, '\n')
            continue
        if not os.path.exists(videoPath):
            print('video not found: ', videoPath, '\n')
            continue
        if not os.path.exists(destXMLFolder + '/formatedXML'):
            os.makedirs(destXMLFolder + '/formatedXML')
        if not os.path.exists(destXMLFolder + '/formatedJSON'):
            os.makedirs(destXMLFolder + '/formatedJSON')
        valide += 1
    print('valide: ', valide, ' in all: ', len(results))
