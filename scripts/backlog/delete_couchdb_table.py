import couchdb, logging

class CouchDeletor:
    def __init__(self, server='127.0.0.1', port='5984'):
        serverUrl = 'http://' + server + ':' + port + '/'
        self.couch = couchdb.Server(url=serverUrl)

    def delete(self):
        try:
            self.couch.delete("video")
            self.couch.delete("program")
            self.couch.delete("sequence")
            self.couch.delete("scene")
            self.couch.delete("shot")

            self.couch.create("video")
            self.couch.create("program")
            self.couch.create("sequence")
            self.couch.create("scene")
            self.couch.create("shot")
        except TimeoutError:
            logging.error("time out: can't connect to couchdb")
            return 1
        return 0

if __name__ == "__main__":
    deletor = CouchDeletor()
    deletor.delete()
