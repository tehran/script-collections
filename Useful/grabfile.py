# encoding: utf-8
import urllib2
from bs4 import BeautifulSoup
import urllib
import os
import errno
import requests

def downloadfile(filename):
    encoded_url = filename
    filename = "files/"+urllib.unquote(filename).encode('utf-8')
    if not os.path.exists(os.path.dirname(filename)):
        try:
            os.makedirs(os.path.dirname(filename))
        except OSError as exc: # Guard against race condition
            if exc.errno != errno.EEXIST:
                raise

    os.system('wget https://url.com/{0} -O "{1}"'.format(encoded_url, filename))
    return filename

def geturl(url):
    content = []
    i=0
    old_path = url
    try:
        page = urllib2.urlopen("https://url.com/"+url).read()
        soup = BeautifulSoup(page, 'html.parser')
        body = soup.find('body', {"bgcolor" : "white"})
        tags = body.find_all('a')
        for tag in tags:
            url = tag.get('href')
            if url != "../":
                content.append(url)
                if (os.path.splitext(url)[1]) is "":
                    geturl(old_path+url)
                else:
                    downloadfile(old_path+url)
    except (AttributeError):
        pass
    return content

currentpath = ""
get_current_path = geturl(currentpath)
print get_current_path
