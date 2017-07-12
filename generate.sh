#!/bin/bash
# update submodules
git submodule foreach git pull origin master
# add and commit to git (yaml files)
git add *
git commit -m "updated yaml data files"
# sync with git
git push origin master
# get vc info (pythonw)
pythonw gfi-run.py
# delete contents of output
rm -rf output
# mkdir
mkdir output
chmod 777 output
# move gfi files to output
mv cv.web.de.gfi output/cv.web.de.gfi
mv cv.web.en.gfi output/cv.web.en.gfi
mv cv.de.gfi output/cv.de.gfi
mv cv.en.gfi output/cv.en.gfi
# create files
ruby generate.rb -w 					# cv.web.de.md
ruby generate.rb						# cv.de.md
# ruby generate.rb -e						# cv.en.md
# ruby generate.rb -e -w					# cv.web.en.md
ruby generate.rb -t cv.tex.erb -w		# cv.web.de.tex
ruby generate.rb -t cv.tex.erb			# cv.de.tex
# ruby generate.rb -t cv.tex.erb -w -e	# cv.web.en.tex
# ruby generate.rb -t cv.tex.erb -e		# cv.en.tex
# web.md version are copied to cv-data by generate.rb
# switch to output directory
cd output
# xelatex run twice for page numbers and bibliography
xelatex cv.web.de.tex -interaction=batchmode
xelatex cv.web.de.tex -interaction=batchmode 
xelatex cv.de.tex -interaction=batchmode
xelatex cv.de.tex -interaction=batchmode
xelatex cv.web.de.tex -interaction=batchmode
xelatex cv.web.de.tex -interaction=batchmode
xelatex cv.en.tex -interaction=batchmode
xelatex cv.en.tex -interaction=batchmode
xelatex cv.web.en.tex -interaction=batchmode
xelatex cv.web.en.tex -interaction=batchmode
# copy to _cv-data/pdf
cp cv.web.de.pdf ../../_cv-data/pdf
cp cv.web.en.pdf ../../_cv-data/pdf
# copy to _cv-data/private/pdf
cp cv.de.pdf ../../_cv-data/private/pdf
cp cv.en.pdf ../../_cv-data/private/pdf
# copy to _cv-data/private/
cp cv.de.md ../../_cv-data/private
cp cv.en.md ../../_cv-data/private
# commit to git: cv-data
cd ../../_cv-data
git add *
git commit -m "updated to newest versions"
git push origin master
# clean-up output directory
cd ../_cv-app
rm -rf output
