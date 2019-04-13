#!/usr/bin/env python
#coding=utf-8


import sys
import os
import os.path
import io

# 检测一个类是否添加的必要的注释说明 没有注释返回False
def check_annotation(file_name):
    res = True
    if file_name.find('VC.h') == -1 and file_name.find('Controller.h') == -1:
        return res

    try:
        with io.open(file_name, 'r', encoding='utf-8') as data:
            i = 0
            for eachline in data:
                i = i + 1
                if i == 7:
                    line_clean = ''.join(eachline.strip('\n').split(' '))
                    if len(line_clean) < 5:
                        res = False
                    break

    except BaseException as error:
        print('读取文件出错: ', str(error))

    return res


# 检测变更的文件中类是否添加的必要的注释说明
def judge_files(files):
    # 定义退出code
    code = 0

    # 遍历文件 检出.h中是否带有对该类的注释说明
    for file_name in files:
        name = file_name.strip('\n')
        if len(name) < 2:
            continue

        # 取后缀
        ext = name[-2:]

        # 是.h则检测
        if ext == '.h':
            res = check_annotation(name)
            if res is False:
                last_part = os.path.basename(file_name).strip('\n')
                code = 1
                print("请确认在 %s 中第七行是否添加了足额必要的注释(最少五个字)" % (last_part))
                print('特殊情况, 可以临时使用 --no-verify 规避检测')
                break


    return code

# 检测文件名中是否有空格 有空格返回True
def check_space(files):
    # 定义退出code
    code = 0
    for file_name in files:
        name = file_name.strip('\n')
        res = name.split(' ')
        if (len(res)) > 1:
            code = 1
            print("请删除在 %s 中包含的空格" % (name))
            print('特殊情况, 可以临时使用 --no-verify 规避检测')
            break

    return code



############### 开启检测:
# 拿到所有变更的文件名
files = os.popen('git diff --cached --name-only')

code = judge_files(files)
if code == 0:
    print('类头文件注释检测通过')
else:
    sys.exit(1)

# 拿到所有变更的文件名
files = os.popen('git diff --cached --name-only')
code = check_space(files)
if code == 0:
    print('文件名空格检测通过')
    sys.exit(0)
else:
    sys.exit(1)

