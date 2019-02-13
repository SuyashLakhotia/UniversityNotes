# CZ 4041 - Machine Learning

The notes for Machine Learning in this folder are **not written in GitHub Flavored Markdown** and may not render properly on the browser. You can either download the [PDF](!%20-%20Machine%20Learning.pdf) or clone this repo and build the PDF from source (instructions below).

### Building PDF from Source (macOS)

First, install TeX and Pandoc:

```bash
$ brew cask install mactex
$ brew install pandoc
```

Now, you can either run `build.sh` to build the PDF or automatically build the PDF while editing using `watch-cli`:

```bash
$ npm install -g watch-cli
$ watch -p "*.{md,txt}" -c "./build.sh"
```
