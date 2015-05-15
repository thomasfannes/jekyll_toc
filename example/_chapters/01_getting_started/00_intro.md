---
title: Introduction to TOC
---

# {{ page.toc.nice_sec }} : {{ page.title }}

The TOC module generates a table of contents for a collection. In this example, the collection is the chapters collection, and looks like this:

 * _chapters
   * 01_first_chapter
     * 00_intro.md
     * 01_content.md
     * 02_outro.md
   * 02_second_chapter
     * 01_end.md
     * overview.md

  The directories or files under _chapters become section (ordered alphabetically), subdirectories become subsections, subsubdirectories subsubsections, etc. After the TOC is build (by the plugin), it can be used to
  
   * generate a (local) table of contents
   * get the next, previous or parent page in the collection
   * get all the children
   * get the section numbering for this page
   * generate automatic overview pages
   
  So let's get started, let's go to the next section (section {{ page.toc.next.toc.sec }} ) by clicking this [link]( {{ page.toc.next.url }} )
