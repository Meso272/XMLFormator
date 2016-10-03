import logging

import couchdb


class Helper:
    def __init__(self, ip, port):
        serverUrl = 'http://' + ip + ':' + port + '/'
        self.couch = couchdb.Server(url=serverUrl)
        try:
            self.videodb = self.couch['video']
            self.programdb = self.couch['program']
            self.sequencedb = self.couch['sequence']
            self.scenedb = self.couch['scene']
            self.shotdb = self.couch['shot']
            self.dblist = [self.videodb, self.programdb, self.sequencedb, self.scenedb, self.shotdb]
            self.connected = True
        except TimeoutError:
            logging.error("can't connect to couchdb: %s" % serverUrl)
            self.connected = False

    def add(self):
        if not self.connected:
            return
        for db in self.dblist:
            total = len(db)
            count = 0
            for _id in db:
                count += 1
                try:
                    doc = db[_id]
                    VideoPath = doc["Metadata"]["VideoPath"]
                    VideoPlayPath = VideoPath.replace("input", "video_play")[:-3] + "mp4"
                    doc["Metadata"]["VideoPlayPath"] = VideoPlayPath
                    db.save(doc)
                    print(db.name + ": ", count, "/", total, end="\r")
                except:
                    print("error: " + _id)
            print()


helper = Helper("192.168.1.8", "5984")
helper.add()
