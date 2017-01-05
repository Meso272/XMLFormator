import uuid


class Video:
    def __init__(self, log_id, vendor_name, upload_time, uploader_name, xml_upload_path, video_upload_path,
                 video_cut_path, frame_extract_path, vendor_path, video_price, video_copyright, material_id,
                 video_play_path, xml_trans_path):
        self.log_id = log_id
        self.vendor_name = vendor_name
        self.upload_time = upload_time
        self.uploader_name = uploader_name
        self.xml_upload_path = xml_upload_path
        self.video_upload_path = video_upload_path
        self.video_cut_path = video_cut_path
        self.frame_extract_path = frame_extract_path
        self.vendor_path = vendor_path
        self.video_price = video_price
        self.video_copyright = video_copyright
        self.material_id = material_id
        self.video_play_path = video_play_path
        self.xml_trans_path = '/'.join(xml_trans_path.split('/')[:-1]) + '/' + str(uuid.uuid4()).replace('-', '')
