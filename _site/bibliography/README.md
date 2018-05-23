# Bibliography
BibTeX bibliography of my publications, continuously updated. Includes TeX-files for German and English lists of publications, including version control information via [`gitfile-info`](https://www.ctan.org/pkg/gitfile-info?lang=de). 

`gitfile-info` is monkey patched to check for version control information of the `.bib`-file (and not the `.tex`-files).

## Workflow for LaTeX-files
* Run `sh bib-generate.sh`

or

1. Update bib-file
2. Commit and sync changes
3. Run `pythonw gfi-run.py` in working directory to get and store version number
4. Run `pdflatexmk` to typeset list of publications
5. Upload PDF files to server (or use the files stored on [GitHub](https://www.github.com))

## To-Do
* ~~Create `Makefile` to automatically execute the workflow~~ (switched to shell script)
* ~~Add option to create Markdown versions (currently done via [citeproc-ruby](https://github.com/inukshuk/citeproc-ruby) and [jekyll-scholar](https://github.com/inukshuk/jekyll-scholar) for my [website](https://www.stefangroth.com/publications))~~
* Change sort order for markdown version to: newest to oldest
* ~~Implement i18n-support to prevent duplicate versions (English, German)~~ (switched to temporary English version of the bibliography and using `sed` to replace a number of special strings) 
