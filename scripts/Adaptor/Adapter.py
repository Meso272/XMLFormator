import MySQLdb
import sys
import logging
from _mysql_exceptions import *


class Adapter:
    def __init__(self, host, user, password, db):
        try:
            self.connection = MySQLdb.connect(host=host, user=user, password=password, db=db, charset='utf8')
            self.cursor = self.connection.cursor()
        except OperationalError:
            logging.error("can't connect to mysql: %s" % host)
            sys.exit(1)

    def run_sql(self, sql):
        try:
            self.cursor.execute(sql)
        except ProgrammingError:
            logging.info("error in sql: %s" % sql)
        except IntegrityError:
            logging.info("检查约束失败: %s" % sql)
