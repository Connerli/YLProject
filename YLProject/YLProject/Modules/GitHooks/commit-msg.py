#!/usr/bin/env python
#coding=utf-8

import sys
import os
import os.path
import io


def commit_format():
    print('commit message 不符合规范, 请参考:')
    print('feat: 新功能')
    print('fix(dev): 修复开发版本的bug')
    print('fix(dis): 修复发布版本的bug')
    print('style: 格式修整,review时增加一些注释等')
    print('refactor: 代码重构')
    print('chore: 项目构建,打包')
    print('cherry: 遴选')
    print('conflict: 冲突解决')
    print('Merge branch: 合并代码自动生成的')
    print('如果是引用导入第三库或者其它情况,可以临时使用 --no-verify 规避检测')


args = sys.argv[1]
with io.open(args, 'r', encoding='utf-8') as data:
    message = data.readline().strip('\n')
    prefix = message[:12]
    if prefix == 'Merge branch':
        print('commit message检测通过')
        sys.exit(0)

    style = message.split(':')
    if len(style) < 2:
        commit_format()
        sys.exit(1)

    prefix = style[0]
    prefix = prefix.lower()
    if prefix != 'feat' and prefix != 'fix(dev)' and prefix != 'fix(dis)' and prefix != 'style' and prefix != 'refactor' and prefix != 'chore' and prefix != 'cherry' and prefix != 'conflict' and prefix != 'Merge branch':
        commit_format()
        sys.exit(1)

print('commit message检测通过')
sys.exit(0)



