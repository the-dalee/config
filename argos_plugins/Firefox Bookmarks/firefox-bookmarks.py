#!/usr/bin/env python3
import sqlite3
from shutil import copyfile
from tempfile import NamedTemporaryFile

# --------------------------------------------
# Configuration
# --------------------------------------------
# Insert path of places.sqlite file here.
# See https://support.mozilla.org/en-US/kb/profiles-where-firefox-stores-user-data
PLACES_PATH = ''


# ------------------------------------------------
# Plugin code
# ------------------------------------------------

TYPE_LINK = 1
TYPE_FOLDER = 2
TYPE_SEPARATOR = 3

f = NamedTemporaryFile()
copyfile(PLACES_PATH, f.name)

conn = sqlite3.connect(f.name)


def print_bookmarks(parent=3, prefix=''):
    sql = f'''SELECT b.title, p.url, b.type, b.id FROM moz_bookmarks b LEFT JOIN moz_places p ON b.fk = p.id WHERE b.parent = {parent} ORDER BY position;'''
    cursor = conn.cursor()
    for bookmark in cursor.execute(sql):
        if bookmark[2] == TYPE_LINK:
            print(f"{prefix}{bookmark[0]} | href={bookmark[1]}")
        if bookmark[2] == TYPE_FOLDER:
            print(f"{prefix}{bookmark[0]}")
            print_bookmarks(parent=bookmark[3], prefix=prefix + '--')
        if bookmark[2] == TYPE_SEPARATOR:
            print("---")


print('Firefox Bookmarks')
print('---')
print_bookmarks()


