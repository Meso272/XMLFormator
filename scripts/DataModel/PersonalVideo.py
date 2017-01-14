import cv2
import os


class PersonalVideo:
    def __init__(self, material_id, title, video_path, vendor_path, keywords, produced_time, hours, minutes, seconds,
                 copyright, mtype, format, brief, price, xml_formatted, video_play_path, price_type, thumbnail,
                 duration, periods):
        self.material_id = material_id
        self.title = title
        self.video_path = video_path
        self.vendor_path = vendor_path
        self.keywords = keywords
        self.produced_time = produced_time
        self.hours = hours
        self.minutes = minutes
        self.seconds = seconds
        self.duration = duration if duration else self.get_video_duration(video_path) # self.get_video_duration(video_path)
        self.copyright = copyright
        self.mtype = mtype
        self.format = format
        self.brief = brief
        self.price = price
        self.xml_formatted = xml_formatted
        self.video_play_path = video_play_path
        self.price_type = price_type
        self.thumbnail = thumbnail if thumbnail else ''
        self.periods = periods if periods else 0

    @staticmethod
    def get_video_duration(file_path):
        if not os.path.isfile(file_path):
            return 0
        try:
            cap = cv2.VideoCapture(file_path)
            return int(cap.get(cv2.CAP_PROP_FRAME_COUNT)) * 0.04
        except:
            return 0

