from sql_trigger import SQLTrigger
import argparse, logging

if __name__ == "__main__":
    logging.basicConfig(format='%(levelname)s:%(message)s', level=logging.WARNING)
    parser = argparse.ArgumentParser()
    parser.add_argument("-s", "--server", help="mysql erver address", default="localhost")
    parser.add_argument("-u", "--user", help="mysql user name", default="root")
    parser.add_argument("-p", "--passwd", help="mysql password", default="pkulky201")
    parser.add_argument("-db", "--database", help="database name", default="upload_log")

    args = parser.parse_args()
    sql_trigger = SQLTrigger(host=args.server, user=args.user, passwd=args.passwd, db=args.database)
    sql_trigger.run()
