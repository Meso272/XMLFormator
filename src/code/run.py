import argparse
import logging

from ConfRepo import ConfRepo
from CouchdbUploader import Uploader
from PersonalGenerator import PersonalXMLGenerator
from SqlTrigger import SQLTrigger

if __name__ == "__main__":
    logging.basicConfig(format='%(levelname)s:%(message)s', level=logging.DEBUG)
    parser = argparse.ArgumentParser()
    parser.add_argument("-s", "--server", help="mysql erver address")
    parser.add_argument("-u", "--user", help="mysql user name")
    parser.add_argument("-p", "--passwd", help="mysql password")
    parser.add_argument("-db", "--database", help="database name")
    parser.add_argument("-port", "--port", help="database port")
    parser.add_argument("--media", help="only process media info. don't upload to couchdb", default=False)

    confRepo = ConfRepo()
    args = parser.parse_args()

    upload_log_ip = args.server if args.server else confRepo.getParam('upload_log', 'ip')
    upload_log_port = args.port if args.port else confRepo.getParam('upload_log', 'port')
    upload_log_password = args.passwd if args.passwd else confRepo.getParam('upload_log', 'password')
    upload_log_user = args.user if args.user else confRepo.getParam('upload_log', 'user')
    upload_log_db = args.database if args.database else confRepo.getParam('upload_log', 'db')

    tps_ip = confRepo.getParam('tps', 'ip')
    tps_port = confRepo.getParam('tps', 'port')
    tps_user = confRepo.getParam('tps', 'user')
    tps_password = confRepo.getParam('tps', 'password')
    tps_db = confRepo.getParam('tps', 'db')

    couchdb_ip = confRepo.getParam('couchdb', 'ip')
    couchdb_port = confRepo.getParam('couchdb', 'port')

    try:
        generator = PersonalXMLGenerator(tps_ip, tps_user, tps_password, tps_db)
        generator.generate()
    except:
        logging.error("generate personal xml failed")

    sql_trigger = SQLTrigger(host=upload_log_ip, user=upload_log_user, passwd=upload_log_password, db=upload_log_db)
    sql_trigger.run()

    if not args.media:
        uploader = Uploader(sql_server=upload_log_ip, user=upload_log_user, passwd=upload_log_password,
                            sql_db=upload_log_db, couch_server=couchdb_ip, couch_port=couchdb_port)
        uploader.run()
