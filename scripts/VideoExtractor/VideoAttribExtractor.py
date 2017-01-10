import hashlib
import logging
import os

from .FrameExtractor import KeyframeExtractor
from .ThumbnailExtractor import ThumbnailExtractor


# 这个类更纯粹, 不和数据库交互, 功能为: 提取给定视频的MD5, 缩略图, 关键帧
# 参数: 视频路径, 缩略图保存文件夹, 关键帧保存文件夹
class VideoAttribExtractor:

    def __init__(self, video_path, thumbnail_folder, keyframes_folder):
        self.video_path = video_path
        self.thumbnail_folder = thumbnail_folder
        self.keyframes_folder = keyframes_folder

        self.MD5 = ''
        self.thumbnail_path = ''

        if not os.path.exists(self.thumbnail_folder):
            os.makedirs(self.thumbnail_folder)

        if not os.path.exists(self.keyframes_folder):
            os.makedirs(self.keyframes_folder)

    # 给定文件路径，以字符串的形式返回文件的md5
    def get_md5(self):
        md5 = hashlib.md5()
        with open(self.video_path, 'rb') as f:
            for chunk in iter(lambda: f.read(8192), b''):
                md5.update(chunk)
        self.MD5 = md5.hexdigest()
        return md5.hexdigest()
    
    # 给定视频的路径和视频的缩略图保存路径，路径均指定到文件名
    def get_thumbnail(self):
        if not self.MD5:
            self.get_md5()

        self.thumbnail_path = self.thumbnail_folder + "/thumbnail_" + self.MD5 + ".jpeg"
        thumbnail_extractor = ThumbnailExtractor()
        try:
            thumbnail_extractor.thumb_with_ffmpeg(infile=self.video_path, position=0.5, executable=None,
                                             outfile=self.thumbnail_path)
        except:
            logging.error("thumbnail extraction failed for video : %s" % self.video_path)
        return self.thumbnail_path

    # 获得视频的关键帧，给定视频路径和视频关键帧的存放文件夹
    def get_keyframe(self):
        extractor = KeyframeExtractor()
        extractor.extract(self.video_path, self.keyframes_folder, k=3)

    # 提取所有属性, 并返回值
    def extract(self):
        if not os.path.exists(self.video_path):
            logging.error("Video: %s not exists" % self.video_path)
            return 1

        self.get_md5()
        self.get_thumbnail()
        return [self.MD5, self.thumbnail_path, self.keyframes_folder]
