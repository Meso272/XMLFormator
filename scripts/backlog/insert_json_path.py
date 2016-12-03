import MySQLdb, os, sys, logging
from _mysql_exceptions import *


class SQLTrigger:
    def __init__(self, host, user, passwd, charset, db):
        self.host = host
        self.user = user
        self.passwd = passwd
        self.charset = charset
        self.db = db

    def run(self):        
        try:
            db = MySQLdb.connect(host=self.host, user=self.user, passwd=self.passwd, charset=self.charset, db=self.db)
        except OperationalError:
            logging.error("can't connect to mysql")
            sys.exit(1)
    
        formator_record_fetch_cursor = db.cursor(MySQLdb.cursors.DictCursor)
        formator_record_insert_cursor = db.cursor()
    
        sql = "select * from formator_record"
        formator_record_fetch_cursor.run_sql(sql)
        formator_record_fetch_cursor.fetchall()
        if formator_record_fetch_cursor.rowcount == 0:
            logging.warning("There is no upload log record found to process")
            sys.exit(0)
    
        for row in formator_record_fetch_cursor:
            id = row["id"]
            thumbnail = row["thumbnail"] 
    
            json = '/'.join(thumbnail.split('/')[:-2]) + "/json"
            formator_record_insert_sql = "update formator_record set json='%s' where id=%d" % (json, int(id))
            formator_record_insert_cursor.run_sql(formator_record_insert_sql)
            db.commit()
        db.close()

insertor = SQLTrigger()
insertor.run()
