#!/usr/bin/python3

from python_terraform import *
import sys
import os
import argparse
import json
import boto3
import ansible_runner

import pandas as pd

import smtplib
from email.mime.multipart import MIMEMultipart
from email.mime.base import MIMEBase
from email.mime.text import MIMEText
from email import encoders

###--ec2 details
tf1 = Terraform(working_dir='/home/ubuntu/ansible/deva/saas_final_ec2_rds/')
print(tf1)
print(tf1.init())
print(tf1.plan())
print(tf1.apply(skip_plan=True))

output1= tf1.output()
print(output1)
final_output=output1['public_ip']['value']
publicip=final_output[0][0]

dns=output1['DNS_name']['value']
base_url = "https://"+dns+"/ovaledge/"

#publicip='18.188.192.207'
print("EC2 PublicIP : ",publicip)


#RDS_username = output1['username']['value']
#RDS_password = output1['password']['value']
#RDS_endpoint = output1['rds_endpoint']['value']
#RDS_endpoint = RDS_endpoint[:len(RDS_endpoint) -5]

secretmanager_name = output1['secret_manager_name']['value']
tf1.close()

hosts = open("/home/ubuntu/ansible/deva/hosts", "rt")
hostsdata = hosts.read()
hostsdata = hostsdata.replace('ANS_PUBLIC_IP', publicip)
hosts.close()
hostsout = open("/home/ubuntu/ansible/deva/hostsmain", "wt")
hostsout.write(hostsdata)
hostsout.close()


#cmd = 'ansible-inventory -i inv.py --list --output host.txt'
#os.system(cmd)
hostinv = open("/home/ubuntu/ansible/deva/hostsmain", "rt")
hostinvdata = hostinv.read()
print(hostinvdata)
hostinv.close()



fin = open("/home/ubuntu/ansible/deva/tomcat-test.yaml", "rt")
data = fin.read()
#data=data.replace('RDS_endpoint', RDS_endpoint)
#data=data.replace('RDS_username', RDS_username)
#data=data.replace('RDS_password', RDS_password)
data=data.replace('BASE_URL_AUTO', base_url)
data=data.replace('SECRET_MANAGER_NAME',secretmanager_name)

print(data)
fin.close()
fout=open("/home/ubuntu/ansible/deva/tomcat-deployment.yaml", "wt")
fout.write(data)
fout.close()

r = ansible_runner.run(private_data_dir='/home/ubuntu/ansible/deva/',inventory=hostinvdata, playbook='/home/ubuntu/ansible/deva/tomcat-deployment.yaml')
print("{}: {}".format(r.status, r.rc))
# successful: 0
for each_host_event in r.events:
    print(each_host_event['event'])
print("Final status:")
print(r.stats)
#url="https://saasoe.ovaledge.net/ovaledge/login"
url="https://"+dns+"/ovaledge/login"
print("Deployment is successful\nApplication is accessible on : ",url)

############# mail part
sender='devanandareddy.raptadu@ovaledge.com'
sender_pass='Dev@0213'

msg = MIMEMultipart()
msg['From'] = sender
msg['To'] = "devanandareddy.raptadu@ovaledge.com;sireesha.ponduru@ovaledge.com"
#'gayathri.govada@ovaledge.com;kavya.gurram@ovaledge.com;shivaprasad.mergu@ovaledge.com;girivardhan.sirivella@ovaledge.com;chakradhar.vemulapati@ovaledge.com'
#'skadiyala@ovaledge.com;chakradhar.vemulapati@ovaledge.com'
# msg['Cc'] = 'ravindra.k@kpk.in'
# msg['bcc'] = 'santosh.b@kpk.in'
msg['Subject'] = "Running EC2 and RDS Instances"
body = 'Hi Team\n\n Please find the below URL to access ovaledge application.\nURL: '+url+'\n\nRegards,\nDevananda.\n\n'
msg.attach(MIMEText(body, 'plain'))

server = smtplib.SMTP('smtp.gmail.com', 587) 
server.ehlo()
server.starttls()
server.ehlo()
server.login(sender, sender_pass)
server.send_message(msg)
server.quit()
print("mail sent")


#print("completed")

