---
title:
author:
address:
output:
  pdf_document:
    fig_caption: true
    latex_engine: pdflatex
    keep_tex: yes
    number_sections: true
    toc: true
  word_document:
    fig_caption: true
bibliography:
  - references.bib
csl: nature.csl
longtable: true
urlcolor: blue
header-includes:
  - \usepackage{longtable}
  - \usepackage{graphicx}
  - \usepackage{booktabs}
  - \usepackage{textcomp}
  - \usepackage{xcolor}
  - \usepackage{colortbl}
  - \usepackage{geometry}
  - \usepackage{subcaption}
  - \usepackage{lineno}
  - \definecolor{listcomment}{rgb}{0.0,0.5,0.0}
  - \definecolor{listkeyword}{rgb}{0.0,0.0,0.5}
  - \definecolor{listnumbers}{gray}{0.65}
  - \definecolor{listlightgray}{gray}{0.955}
  - \definecolor{listwhite}{gray}{1.0}
  - \definecolor{FSL}{rgb}{0.764,0.729,0.271}
  - \definecolor{FreeSurfer}{rgb}{0.318,0.616,0.722}
  - \definecolor{ANTsX}{rgb}{0.851,0.129,0.125}
geometry: margin=1.0in
fontsize: 12pt
linestretch: 1.5
mainfont: Georgia
---

\linenumbers