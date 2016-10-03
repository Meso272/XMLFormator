from sql_trigger import SQLTrigger
from couchdb_importor import Uploader
import argparse, logging
from gen_personal_xml import PersonalXMLGenerator


if __name__ == "__main__":
    logging.basicConfig(format='%(levelname)s:%(message)s', level=logging.DEBUG)
    parser = argparse.ArgumentParser()
    parser.add_argument("-s", "--server", help="mysql erver address", default="localhost")
    parser.add_argument("-u", "--user", help="mysql user name", default="root")
    parser.add_argument("-p", "--passwd", help="mysql password", default="pkulky201")
    parser.add_argument("-db", "--database", help="database name", default="upload_log")

    parser.add_argument("--media", help="only process media info. don't upload to couchdb", default=False)

    """
    try:
        generator = PersonalXMLGenerator()
        generator.generate()
    except:
        logging.error("generate personal xml failed")        
    """
    args = parser.parse_args()
    sql_trigger = SQLTrigger(host=args.server, user=args.user, passwd=args.passwd, db=args.database)
    sql_trigger.run()

    if not args.media:
        uploader = Uploader()
        uploader.run()
