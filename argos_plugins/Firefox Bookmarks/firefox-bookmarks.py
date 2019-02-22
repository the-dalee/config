#!/usr/bin/env python3
import base64
import sqlite3
from shutil import copyfile
from tempfile import NamedTemporaryFile
import requests

# --------------------------------------------
# Configuration
# --------------------------------------------

# Insert path of places.sqlite file here.
# See https://support.mozilla.org/en-US/kb/profiles-where-firefox-stores-user-data
PLACES_PATH = ''

# Insert path of favicons.sqlite file here.
# See https://support.mozilla.org/en-US/kb/profiles-where-firefox-stores-user-data
FAVICONS_PATH = ''


# ------------------------------------------------
# Plugin code
# ------------------------------------------------

TYPE_LINK = 1
TYPE_FOLDER = 2
TYPE_SEPARATOR = 3

places_file = NamedTemporaryFile()
favicons_file = NamedTemporaryFile()

copyfile(PLACES_PATH, places_file.name)
copyfile(FAVICONS_PATH, favicons_file.name)

places_conn = sqlite3.connect(places_file.name)
favicons_conn = sqlite3.connect(favicons_file.name)


def fetch_icons():
    sql = "SELECT p.page_url, i.icon_url FROM moz_pages_w_icons p LEFT JOIN moz_icons_to_pages itp ON itp.page_id = p.id LEFT JOIN moz_icons i ON itp.icon_id = i.id;"
    cursor = favicons_conn.cursor()
    return {favicon[0]: favicon[1] for favicon in cursor.execute(sql)}


def download_icon(url):
    response = requests.get(url)
    try:
        content = response.content
        return base64.standard_b64encode(content).decode('ascii')
    except Exception as e:
        return None


def print_bookmarks(parent=3, prefix=''):
    icons = fetch_icons()

    sql = f'''SELECT b.title, p.url, b.type, b.id FROM moz_bookmarks b LEFT JOIN moz_places p ON b.fk = p.id WHERE b.parent = {parent} ORDER BY position;'''
    cursor = places_conn.cursor()
    for bookmark in cursor.execute(sql):
        bookmark_title = bookmark[0]
        bookmark_url = bookmark[1]
        bookmark_type = bookmark[2]
        bookmark_parent = bookmark[3]
        bookmark_icon_url = icons.get(bookmark_url)

        bookmark_icon = download_icon(bookmark_icon_url) if bookmark_icon_url else None

        if bookmark_type == TYPE_LINK:
            if bookmark_icon:
                print(f"{prefix}{bookmark_title} | href={bookmark_url} | image={bookmark_icon} | imageWidth=16")
            else:
                print(f"{prefix}{bookmark_title} | href={bookmark_url} | iconName=user-bookmarks")
        if bookmark_type == TYPE_FOLDER:
            print(f"{prefix}{bookmark_title} | iconName=folder")
            print_bookmarks(parent=bookmark_parent, prefix=prefix + '--')
        if bookmark_type == TYPE_SEPARATOR:
            print("---")


print('Firefox Bookmarks')
print('---')
print_bookmarks()
