CV
======

This bilingual CV system stores content in a YAML file and uses Ruby's ERB templating system to handle format and layout. The templates currently implemented are Markdown and LaTeX; HTML and plain text will follow. You can use `xelatex` to create a PDF file from the generated LaTeX file.

`escape_html.rb`, `escape_md.rb` `escape_tex.rb`, and `escape_txt.rb` define `escape` functions for handling special characters or cases. (For example, `&` must be escaped as `\&amp;` in HTML, and `\\&` in LaTeX. The `escape` function also handles other special cases, including links.) Escape characters must appear in square brackets in the YAML file. For example, to include an ampersand, use `[&]`.

Store private contact information in the `private.de.yaml` and `private.en.yaml` files. This information will be omitted from the "web" version of the generated CV (selected with the `-w` or `--web` option). This is to prevent certain contact information (e.g. phone number, address) from being uploaded to a public repository or website. For an example, see `private.example.yaml`.

The `-e` or `--english` option creates an English version of the CV, using both an `i18n` dictionary file (`i18n/en.i18n`) and an English version `yaml` file with translated information on courses etc. By default, `i18n/de.i18n` and `cv.de.yaml` are used to create the German versions. 

This project is a fork from [Ming-Ho Yee's project](https://github.com/mhyee/resume) which was inspired by [David Hu's resume project](https://github.com/divad12/resume).

For examples, my templates are included in this repository, while the generated
resumes are on [my website](https://www.stefangroth.com/cv).

### Usage

Feel free to fork or use this project and adapt the templates for your own
resume. (Obviously, the resume content is mine.)

    Usage: generate.rb [options]
        -i, --input INPUT                input file
        -p, --private PRIVATE            private input file
        -t, --template TEMPLATE          template file
        -w, --web                        create a web version omitting private information
        -e, --english                    create an English version

### Shell Script

The shell script `generate.sh` generates `.tex`, `.md` and `.pdf` versions of my CV in German and English as well as separate web versions without private data. Public files are pushed to the `_cv-data`-repo. Further, `presentations.md` and a `presentations.tex` files are created for use in [lists of publication](https://github.com/sgroth/bibliography).

### To-Do

* Create `.txt` and `.html` versions
* Create `.docx` versions by using [Pandoc](http://pandoc.org)
* ~~Create `Makefile`~~
* Clean up `i18n` files and fully translate the `yaml` files

### Dependencies

* Ruby
* LaTeX

### License

The resume content in this repo (`cv.de.yaml` and `cv.en.yaml`) is copyrighted by [Stefan Groth](https://www.stefangroth.com).

The rest of the project is licensed under the MIT License.

