from bs4 import BeautifulSoup
import requests
import datetime
import urllib
import time
import os
import re

                                          # 需要修改的参数
data_path = r"G:\GZ\POD\1"   # 哨兵数据存在的目录 默认是寻找zip文件
orbit_path = r"G:\GZ\POD"  # 精轨数据存在的目录

error_url = []
url_prefix = 'https://qc.sentinel1.eo.esa.int/aux_poeorb/' # 哨兵卫星精轨网址
headers = {'User-Agent':'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/55.0.2883.87 Safari/537.36'}


def download(path, url):                    # 下载轨道数据
    try:
        orbit_data=requests.get(url)
        with open(path,'wb') as f:
            f.write(orbit_data.content)     # 写入内容
    except:
        error_url.append(url)
    else:                                   # 没有异常
        if url in error_url:                # 在错误列表里
            error_url.remove(url)

def get_yestoday(mytime):                   # 得到影像日期的前一天
    myday = datetime.datetime( int(mytime[0:4]),int(mytime[4:6]),int(mytime[6:8]) )
    delta = datetime.timedelta(days=-1)
    my_yestoday = myday + delta
    my_yes_time = my_yestoday.strftime('%Y%m%d')
    return my_yes_time

if __name__ == '__main__':
    files = os.listdir(data_path)   
    for file in files:                      # 遍历文件夹
        if file.endswith(".zip"):           # 可以修改为'.SAFE'
            print('Downloading POD of time:' + file[17:25])                     # 拼接URL
            url_param_json = {}
            url_param_json['sentinel1__mission'] = file[0:3]
            date = re.findall(r"\d{8}",file)[0]

            # 若参数为20170316，则搜索的是20170317的数据
            # 所以参数应该提前一天
            # 求date的前一天
            date = get_yestoday(date)

            # 在字符串指定位置插入指定字符
            # 例：20170101 --> 2017-01-01
            tmp = list(date)
            tmp.insert(4,'-')
            tmp.insert(7,'-')
            date = "".join(tmp)
            url_param_json['validity_start'] = date

                                                                                    # 获得EOF下载网址
            url_param = urllib.parse.urlencode(url_param_json)                      #  url参数
            url = 'https://qc.sentinel1.eo.esa.int/aux_poeorb/?%s' % url_param      # 拼接
            html = requests.get(url,headers=headers)                                # 获取html
            dom = BeautifulSoup(html.text,"html.parser")                            # 解析html文档
            a_list = dom.findAll("a")                                               # 找出<a>
            eof_lists = [a['href'] for a in a_list if a['href'].endswith('.EOF')]   # 找出EOF
            for eof in eof_lists:
                eofname=eof.split('/')[-1]
                savefile = os.path.join(orbit_path,eofname)
                print(eof)
                download(savefile,eof)
            print('Download successful')

    print("------------------------------------")
                                                    # 下载出错的数据重新下载
    while len(error_url)!=0:
        print("开始下载出错的数据")
        print("出错的数据有")
        print(error_url)
        for eof in error_url:
            eofname=eof.split('/')[-1]
            savefile = os.path.join(orbit_path,eofname)
            download(savefile,eof)

    print("全部下载成功，无出错文件")
