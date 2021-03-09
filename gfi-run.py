#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# -*- mode:python -*-
import os
import sys
import time
import codecs
from git import Repo
import locale
# Locales for date set up to de_DE
# Please edit to you needs
try:
    locale.setlocale(locale.LC_ALL, 'de_DE.utf8')
except:
    try:
        locale.setlocale(locale.LC_ALL, 'de_DE')
    except:
        print ("Fehler: bitte prüfen Sie das Ergebnis von 'locale -d' und fügen es in das Script ein.")

# set up the git repo
# path is the current working directory
pathrepo = os.getcwd()
repo = Repo(pathrepo)
assert not repo.bare
git = repo.git
headcommit = repo.head.commit
index = repo.index

# check for specific file (else) or
# every tex file within the git
if len(sys.argv) <= 1:
    # get all the files within the git
    commFiles = git.ls_files(full_name=True).split("\n")

    # iterate through all files and read date/author/commit and
    # write in the help file
    for fl in commFiles:
        flname, flext = os.path.splitext(fl)
        # flfirst, flsep, flsecond = flname.rpartition(".")
        if fl == 'cv.de.yaml':
            rawdate = int(git.log('-1', fl,
                        pretty='format:"%at"').split('"')[1])
            date = [time.strftime("%d. %B %Y %H:%M", time.localtime(rawdate)),
                    time.strftime("%d", time.localtime(rawdate)),
                    time.strftime("%m", time.localtime(rawdate)),
                    time.strftime("%Y", time.localtime(rawdate)),
                    time.strftime("%H", time.localtime(rawdate)),
                    time.strftime("%M", time.localtime(rawdate))]
            author = [git.log('-1', fl, pretty='format:"%an"').split('"')[1],
                      git.log('-1', fl, pretty='format:"%ae"').split('"')[1]]
            commit = [git.log('-1', fl, pretty='format:"%H"').split('"')[1],
                      git.log('-1', fl, pretty='format:"%h"').split('"')[1]]
            f = codecs.open("cv.web.de.gfi", "w")
            # was f = codecs.open("cv.web.de.gfi", "w", encoding="utf-8")
            f.write("% gitfile-info control file\n")
            f.write("\\gfiSetDate{" + date[1] + "}{" + date[2] + "}{" + date[3]  + "}{" + date[4] + "}{" + date[5] + "}{" + date[0] + "}\n")
            f.write("\\gfiSetAuthor{" + author[0] + "}{" + author[1] + "}\n")
            f.write("\\gfiSetCommit{" + commit[0] + "}{" + commit[1] + "}")
            f.close
            g = codecs.open("cv.de.gfi", "w", encoding="utf-8")
            g.write("% gitfile-info control file\n")
            g.write("\\gfiSetDate{" + date[1] + "}{" + date[2] + "}{" + date[3] + "}{" + date[4] + "}{" + date[5] + "}{" + date[0] + "}\n")
            g.write("\\gfiSetAuthor{" + author[0] + "}{" + author[1] + "}\n")
            g.write("\\gfiSetCommit{" + commit[0] + "}{" + commit[1] + "}")
            g.close
            h = codecs.open("cv.web.en.gfi", "w", encoding="utf-8")
            h.write("% gitfile-info control file\n")
            h.write("\\gfiSetDate{" + date[1] + "}{" + date[2] + "}{" + date[3]
                   + "}{" + date[4] + "}{" + date[5] + "}{" + date[0] + "}\n")
            h.write("\\gfiSetAuthor{" + author[0] + "}{" + author[1] + "}\n")
            h.write("\\gfiSetCommit{" + commit[0] + "}{" + commit[1] + "}")
            h.close
            i = codecs.open("cv.en.gfi", "w", encoding="utf-8")
            i.write("% gitfile-info control file\n")
            i.write("\\gfiSetDate{" + date[1] + "}{" + date[2] + "}{" + date[3]
                   + "}{" + date[4] + "}{" + date[5] + "}{" + date[0] + "}\n")
            i.write("\\gfiSetAuthor{" + author[0] + "}{" + author[1] + "}\n")
            i.write("\\gfiSetCommit{" + commit[0] + "}{" + commit[1] + "}")
            i.close
else:
    # get the specific file, read date/author/commit and
    # write the help file
    fl = sys.argv[1]
    flname, flext = os.path.splitext(fl)
    rawdate = int(git.log('-1', fl, pretty='format:"%at"').split('"')[1])
    date = [time.strftime("%d. %m %Y %H:%M", time.localtime(rawdate)),
            time.strftime("%d", time.localtime(rawdate)),
            time.strftime("%m", time.localtime(rawdate)),
            time.strftime("%Y", time.localtime(rawdate)),
            time.strftime("%H", time.localtime(rawdate)),
            time.strftime("%M", time.localtime(rawdate))]
    author = [git.log('-1', fl, pretty='format:"%an"').split('"')[1],
              git.log('-1', fl, pretty='format:"%ae"').split('"')[1]]
    commit = [git.log('-1', fl, pretty='format:"%H"').split('"')[1],
              git.log('-1', fl, pretty='format:"%h"').split('"')[1]]
    f = codecs.open("output/"+flname+".gfi", "w", encoding="utf-8")
    f.write("% gitfile-info control file\n")
    f.write("\\gfiSetDate{" + date[1] + "}{" + date[2] + "}{" + date[3]
            + "}{" + date[4] + "}{" + date[5] + "}{" + date[0] + "}\n")
    f.write("\\gfiSetAuthor{" + author[0] + "}{" + author[1] + "}\n")
    f.write("\\gfiSetCommit{" + commit[0] + "}{" + commit[1] + "}")
    f.close
