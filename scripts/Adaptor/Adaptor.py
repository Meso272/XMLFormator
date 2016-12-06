import MySQLdb
import sys
import logging
from _mysql_exceptions import *


class Adaptor:
    def __init__(self, host, user, password, db):
        try:
            self.connection = MySQLdb.connect(host=host, user=user, passwd=password, db=db, charset='utf8')
            self.cursor = self.connection.cursor(cursorclass=MySQLdb.cursors.DictCursor)
        except OperationalError:
            logging.error("can't connect to mysql: %s" % host)
            sys.exit(1)

    def run_sql(self, sql):
        if not sql:
            logging.warning('empty sql query')
            return None
        try:
            logging.debug(sql)
            self.cursor.execute(sql)
            self.connection.commit()
            logging.debug("commit sql: %s" % sql)
        except ProgrammingError:
            logging.info("error in sql: %s" % sql)
        except IntegrityError:
            logging.info("检查约束失败: %s" % sql)

    def fetch_data(self):
        data = self.cursor.fetchall()
        return data

