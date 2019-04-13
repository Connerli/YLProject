#!/usr/bin/env python
#coding=utf-8

import sys
import os
import os.path
import io
import smtplib
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart


class MyEmail:
    def __init__(self):
        self.user = None
        self.passwd = None
        self.to_list = []
        self.cc_list = []
        self.content = None
        self.tag = None
        self.doc = None


    def send(self):
        try:
        # 链接服务器
            server = smtplib.SMTP_SSL("smtp.exmail.qq.com", port=465)

            #登陆
            server.login(self.user, self.passwd)

            #发送邮件
            server.sendmail("<%s>" % self.user, self.to_list, self.get_attach())

            #关闭
            server.close()
            print('发送提测邮件成功')

        except Exception as e:
            print('发送提测邮件失败')


    def get_attach(self):
        #构造邮件内容
        attach = MIMEMultipart()

        if self.tag is not None:
            # 主题,最上面的一行
            attach["Subject"] = self.tag

        if self.user is not None:
            # 显示在发件人
            attach["From"] = "<%s>" % self.user

        if self.to_list:
            # 收件人列表
            attach["To"] = ";".join(self.to_list)

        if self.cc_list:
            # 抄送列表
            attach["Cc"] = ";".join(self.cc_list)

        if self.content:
            msg = MIMEText(self.content, 'plain', 'utf-8')
            attach.attach(msg)

        return attach.as_string()


def send(content, subject):
    my = MyEmail()
    my.user = "xx@caiyikeji.com"
    my.passwd = "xx"
    my.content = content
    my.to_list = ["shigaoqiang@caiyikeji.com", "guojingjing@caiyikeji.com", "zhouyunyun@caiyikeji.com","yanxingxing@caiyikeji.com"]
    my.cc_list = ["liaodao@caiyikeji.com"]
    my.tag = subject
    my.send()

def getSubject(last_log):
    paramString = last_log.split('--send email?')[1]
    params = paramString.split('&')

    version = '未知版本'
    name = '未知包名'

    for each in params:
        if len(each.split('=')) == 2:
            key = each.split('=')[0]
            value = each.split('=')[1]

            if key == 'version':
                version = value
            elif key == 'name':
                name = value
            else:
                print('不能识别的key:  %s'%(key))


    content = "%s %s 提测" % (name,version)
    return content

def getContent(last_log):
    paramString = last_log.split('--send email?')[1]
    params = paramString.split('&')

    version = '未知版本'
    name = '未知包名'
    load_url = 'https://downapp.9188inc.com/app/ios/liaodao/insideTest/index.html'
    design_url = 'http://lottery.gs.9188.com/liaodao/pm/dash/#g=1&p=native'

    for each in params:
        if len(each.split('=')) == 2:
            key = each.split('=')[0]
            value = each.split('=')[1]

            if key == 'version':
                version = value
            elif key == 'name':
                name = value
            else:
                print('不能识别的key:  %s'%(key))


    content = "Dear all:\n%siOS端已经完成开发,现提交测试.\n下载地址:%s\n原型稿和UI设计稿:%s" % (name,load_url,design_url)
    return content


log = os.popen('git log --pretty=format:"%s" -1')
last_log = None
for each in log:
    last_log = each

if last_log.find("--send email?") != -1:
    content = getContent(last_log)
    subject = getSubject(last_log)
    send(content, subject)
else:
    print('if you want send TC-email after a commit, append "--send email?version=xxx&name=xxx"')

