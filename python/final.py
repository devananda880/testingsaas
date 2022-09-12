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

License = '''UJH+uAs3MMb7YCIjPWestF26P/FFPoJekYdqBeyCuO5KieunNMiFswEvgwgY62pgf6YmRpBTJqKHia+qsQ84iYsGteVVBALqjh/XnbuFvsuvmRAzKXs+5tu7HfloFnOVIRHdA3Ob+O5wK4WkoX4KdmKurE/4RuCvubLZN4Z5DdM='''

tf1 = Terraform(working_dir='/home/ubuntu/ansible/deva/saas_both_final/')
print(tf1)
print(tf1.init())
print(tf1.plan())
terra_apply = tf1.apply(skip_plan=True)
#a = type(terra_apply)
#print("\n\n\n",a)
terra_apply = str(terra_apply)

#print("\n\n\n",type(terra_apply))
output1= tf1.output()
print(output1)



#terra_apply = '''(1, '', '\nError: Invalid reference\n\n  on main.tf line 18, in resource "aws_wafregional_ipset" "ipset":\n  18:   name = try\n\nA reference to a resource type must be followed by at least one attribute\naccess, specifying the resource name.\n')'''


if 'Error' in terra_apply:
  print("terraform got error so destroying")
  print(tf1.destroy(capture_output='yes', no_color=IsNotFlagged, force=IsNotFlagged, auto_approve=True))
  sender='devanandareddy.raptadu@ovaledge.com'
  sender_pass='Dev@0213'
  msg = MIMEMultipart()
  msg['From'] = sender
  msg['To'] = "devanandareddy.raptadu@ovaledge.com"
  msg['Subject'] = "SAAS application "
  body = """Hi Team\n\n Please see the below error in terraform"""+str(terra_apply)+"""\n\nRegards,\nDevananda.\n\n"""
  msg.attach(MIMEText(body, 'plain'))

  server = smtplib.SMTP('smtp.gmail.com', 587)
  server.ehlo()
  server.starttls()
  server.ehlo()
  server.login(sender, sender_pass)
  server.send_message(msg)
  server.quit()
  print("mail sent")

else:
  print("No error occured in the terraform")
  print("so running the ansible script")
  ###########
  final_output=output1['public_ip']['value']
  publicip=final_output[0][0]
  dns=output1['DNS_name']['value']
  base_url = "https://"+dns+"/ovaledge/"
  print("EC2 PublicIP : ",publicip)
  secretmanager_name = output1['secret_manager_name']['value']
  
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
  r = ansible_runner.run(private_data_dir='/home/ubuntu/ansible/deva/',playbook='/home/ubuntu/ansible/deva/tomcat-deployment.yaml')
  print("{}: {}".format(r.status, r.rc))

  if r.rc != 0:
    print("ansible got error so destroying the terraform")
    print(tf1.destroy(capture_output='yes', no_color=IsNotFlagged, force=IsNotFlagged, auto_approve=True))
    sender='devanandareddy.raptadu@ovaledge.com'
    sender_pass='Dev@0213'
    msg = MIMEMultipart()
    msg['From'] = sender
    msg['To'] = "devanandareddy.raptadu@ovaledge.com"
    msg['Subject'] = "SAAS application "
    body = """Hi Team\n\n Ansible script got error please see the ansible output in the console\n\nRegards,\nDevananda.\n\n"""
    msg.attach(MIMEText(body, 'plain'))

    server = smtplib.SMTP('smtp.gmail.com', 587)
    server.ehlo()
    server.starttls()
    server.ehlo()
    server.login(sender, sender_pass)
    server.send_message(msg)
    server.quit()
    print("mail sent")


  else:
    print("Ansible script executed successfully")
    sender='devanandareddy.raptadu@ovaledge.com'
    sender_pass='Dev@0213'
    msg = MIMEMultipart()
    msg['From'] = sender
    msg['To'] = "devanandareddy.raptadu@ovaledge.com"
    msg['Subject'] = "SAAS application "
    mail_cust = dns[:dns.index("ovaledge.cloud")-1]
    body = """Hi """+mail_cust+""" Team,\nGreetings of the day!\nCongratulations on your first step toward a Progressive Data Governance Journey!\n
    Please follow the below instructions to start the journey :\n
    Step 1: Click on """+base_url+"""login\n
    Step 2: Plug in your License Key in the License Page displayedon clicking the above URL :\n"""+License+"""\nStep 3: Make a note of the username and the password that is generated\n
    Step 4: Log in to the application with the above credentials\n
    Step 5: Change the password (recommended)\n
    Step 6: Begin your journey"""
    msg.attach(MIMEText(body, 'plain'))

    server = smtplib.SMTP('smtp.gmail.com', 587)
    server.ehlo()
    server.starttls()
    server.ehlo()
    server.login(sender, sender_pass)
    server.send_message(msg)
    server.quit()
    print("mail sent")



