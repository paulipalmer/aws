#!/usr/bin/python
"""
mmarvin 20190305

This Python script is intended to enable the user to send themselves an
email notification when any given lengthy program (such as a model run) 
is terminated.

This particular example has been adapted for use with gmail. However, it is
recommended for the user to send from a "throw-away" account, because such 
access to gmail requires reduced security settings:
https://support.google.com/a/answer/6260879

This script must be modified to reflect the user's personal credentials.
It must also be executed at runtime of lengthy program.

Example application:
./geos.mp | tee run.log ; python email_program_complete.py

"""

import smtplib

sender = 'sendaddress' #For this setup, must be @gmail.com
receiver = 'receiptaddress'
message = """From: Sender Name <sendaddress>
To: Receiver Name <receiptaddress>
Subject: Program complete

Your submitted program has ended.
"""

server = smtplib.SMTP('smtp.gmail.com',587)
server.ehlo()
server.starttls()
server.ehlo()
server.login("username","password")
server.sendmail(sender,receiver,message)
server.close()
