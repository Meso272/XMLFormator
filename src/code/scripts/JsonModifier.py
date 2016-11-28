import logging
import couchdb
from couchdb.http import *


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
                    doc["Metadata"]["Visible"] = 1
                    doc["Metadata"]["LogID"] = -1
                    doc["Metadata"]["MaterialID"] = -1
                    db.save(doc)
                    logging.error(count, '/', total, end='\r')
                except ResourceConflict:
                    logging.error("id confilict: " + _id)
                except ResourceNotFound:
                    logging.error("file not found in couchdb")
                except ServerError:
                    logging.error("server error")

helper = Helper("162.105.16.229", "5984")
helper.add()
