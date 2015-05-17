# jekyll_toc
A jekyll plugin for automatic structuring of documents


## Introduction

This plugin allows the organization of a collection of documents in a book-like fashion, where content is structured in chapters, section, subsection, etc. The idea is that content is recursively structured in directories, such that the first level represent the chapters, the second level the sections (per chapter), and so on. 

The plugin constructs a table of contents, section numbering, and linking to next/prev/up pages by traversing a collection in alphabetical order. This way, switching two sections or moving a section within another section can be done by simply changing the name or the location of that section.



## Features
 * dividing content in chapters, sections, subsections, etc.
 * Automatic section numbering (e.g. 3.1.2) for a document
 * Easy traversal of content by next-, previous- or up-document
 * Writing a table of contents
 * Automatic overview pages for chapters
 * Easy output, e.g., section 3.1.2. can be found at book/3/1/2/
  
An extend tutorial can be found by cloning the project, and then running the example
```
git clone https://github.com/thomasfannes/jekyll_toc.git
cd jekyll_toc/example
jekyll serv
```
