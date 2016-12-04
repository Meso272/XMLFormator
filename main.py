import logging
from scripts.Task.XMLFormatTask import XMLFormatTask
from scripts.Task.CouchdbUploadTask import Uploader
from scripts.Task.GeneratePersonalTask import GeneratePersonalTask

if __name__ == "__main__":
    try:
        generator = GeneratePersonalTask()
        generator.run()
        formator = XMLFormatTask()
        formator.run()
        uploader = Uploader()
        uploader.run()
    except:
        logging.error("generate personal xml failed")

