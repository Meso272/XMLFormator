from os import listdir
import os
from paramiko import SSHClient
import paramiko
from scp import SCPClient

folder = "/Volumes/Seagate Expansion Drive/数据/节目-第2批/低码/"
ssh = SSHClient()
ssh.load_system_host_keys()
ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
ssh.connect('162.105.180.15', port=10722, password='pkulky201', username='derc')
scp = SCPClient(ssh.get_transport())
# scp.put('/Users/zhouludong/Downloads/scrapy.pdf', 'scrapy.pdf')
# scp.get('test2.txt')


for dir in listdir(folder):
    for name in listdir(folder + dir):
        files = listdir(folder + dir + '/' + name)
        xmlFile = ''
        videoFile = ''
        for file in files:
            if file.endswith('.xml'):
                xmlFile = folder + dir + '/' + name + '/' + file
                scp.put(xmlFile, 'xml/'+file)

scp.close()