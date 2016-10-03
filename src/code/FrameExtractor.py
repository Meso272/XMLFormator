import os
import subprocess
from shutil import copyfile

import cv2
import numpy as np
from PIL import Image
from sklearn.cluster import KMeans


class keyFrameExtractor:
    def __init__(self):
        self.frames = None

    def isBlack(self, imgPath):
        im = Image.open(imgPath).convert('LA')
        pixels = im.getdata()  # get the pixels as a flattened sequence
        black_thresh = 50
        nblack = 0
        for pixel in pixels:
            if pixel[0] < black_thresh:
                nblack += 1
        n = len(pixels)
        if (nblack / float(n)) > 0.5:
            return True
        return False

    def calcHist(self, root='frame'):
        for file in os.listdir(root):
            if not file.endswith('.jpg'):
                continue
            img = cv2.imread(os.path.join(root, file))
            hist1 = cv2.calcHist([img], [0], None, [10], [0, 256])
            hist2 = np.append(hist1, cv2.calcHist([img], [1], None, [10], [0, 256]))
            hist3 = np.append(hist2, cv2.calcHist([img], [2], None, [10], [0, 256]))
            hist = hist3
            hist = np.int32(np.around(hist))
            if isinstance(self.frames, np.ndarray):
                self.frames = np.row_stack((self.frames, hist))
            else:
                self.frames = hist

    def get_k_img(self, imgFolder, k=3):
        if not self.frames:
            self.calcHist(imgFolder)
        model = KMeans(k)
        model.fit(self.frames)
        labels = model.labels_
        centers = model.cluster_centers_
        dists = [None] * k
        imgs = [-1] * k
        for i in range(len(labels)):
            dist = self.getdist(i, centers[labels[i]])
            if dists[labels[i]] and dists[labels[i]] > dist:
                dists[labels[i]] = dist
                imgs[labels[i]] = i
            else:
                dists[labels[i]] = dist
                imgs[labels[i]] = i
        files = os.listdir(imgFolder)
        res = list()
        for imgid in imgs:
            img = cv2.imread(os.path.join(imgFolder, files[imgid]))
            # cv2.imshow('image'+str(imgid), img)
            res.append(os.path.join(imgFolder, files[imgid]))
        # cv2.waitKey(0)
        # cv2.destroyAllWindows()
        return res

    def eraseFiles(self, path):
        folder = path
        for the_file in os.listdir(folder):
            file_path = os.path.join(folder, the_file)
            try:
                if os.path.isfile(file_path):
                    os.unlink(file_path)
                    # elif os.path.isdir(file_path): shutil.rmtree(file_path)
            except Exception as e:
                print(e)

    def eraseBlackImg(self, path):
        folder = path
        for the_file in os.listdir(folder):
            file_path = os.path.join(folder, the_file)
            try:
                if file_path.endswith('jpg') and self.isBlack(file_path):
                    os.unlink(file_path)
                    # elif os.path.isdir(file_path): shutil.rmtree(file_path)
            except Exception as e:
                print(e)

    def extract(self, videoPath, destFolder, k=3):
        if not os.path.exists(destFolder + '/frame'):
            os.makedirs(destFolder + '/frame')
        if not os.path.exists(destFolder + '/keyFrame'):
            os.makedirs(destFolder + '/keyFrame')
        self.eraseFiles(destFolder + '/frame')
        self.eraseFiles(destFolder + '/keyFrame')
        subprocess.call(['ffmpeg', '-loglevel', '16', '-i', videoPath, '-vf', 'select=eq(pict_type\,PICT_TYPE_I)',
                         '-vsync', '2', '-s', '800x600', '-f', 'image2', destFolder + '/frame' + '/frame-%02d.jpg'])
        self.eraseBlackImg(destFolder + '/frame')
        imgs = self.get_k_img(destFolder + '/frame', k)
        for img in imgs:
            copyfile(img, destFolder + '/keyFrame/' + img.split('/')[-1])

    def getdist(self, id, center):
        return (sum((self.frames[id]-center)**2))/len(center)

if __name__ == '__main__':
    extractor = keyFrameExtractor()
    extractor.extract('test/iPadPro.mp4', 'test/result', 10)
