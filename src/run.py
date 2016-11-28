import argparse
import logging

from .scripts.ConfRepo import ConfRepo
from .scripts.PersonalGenerator import PersonalXMLGenerator
from .scripts.SqlTrigger import SQLTrigger
from .scripts.CouchdbUploader import Uploader

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

    upload_log_ip = args.server if args.server else confRepo.get_param('upload_log', 'ip')
    upload_log_port = args.port if args.port else confRepo.get_param('upload_log', 'port')
    upload_log_password = args.passwd if args.passwd else confRepo.get_param('upload_log', 'password')
    upload_log_user = args.user if args.user else confRepo.get_param('upload_log', 'user')
    upload_log_db = args.database if args.database else confRepo.get_param('upload_log', 'db')

    tps_ip = confRepo.get_param('tps', 'ip')
    tps_port = confRepo.get_param('tps', 'port')
    tps_user = confRepo.get_param('tps', 'user')
    tps_password = confRepo.get_param('tps', 'password')
    tps_db = confRepo.get_param('tps', 'db')

    couchdb_ip = confRepo.get_param('couchdb', 'ip')
    couchdb_port = confRepo.get_param('couchdb', 'port')

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
