zip -r code.zip Conf.ini JsonValidation.jar main.py scripts/* xsl log/
scp -P 8022 code.zip luyj@162.105.16.229:~/media_converting/XMLFormator/
ssh -p 8022 luyj@162.105.16.229 'cd /home/luyj/media_converting/XMLFormator; ./deploy.sh'
