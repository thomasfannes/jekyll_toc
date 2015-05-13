---
title: Getting started
---
#{{ page.toc.sec }} {{ page.title }}

To use jekyll on your website, you set the following files:

{% highlight bash %}
.
├── _config.yml          // set the collection (and output to true)
├── _plugins
|   ├── tocgenerator.rb  // generates the toc
|   └── toctag.rb        // tag for generating a table of contents
├── _template
|   ├── overview.md      // default overview template
└── _data
    └── toc.yml          // yml file with settings
{% endhighlight %}

the toc.yml makes it possible to configure the toc-plugin, and should have the following elements:

{% highlight yaml %}
collection: <the name of the collection without trailing _>
auto_generated:
  template: <the template to use when autogenerating file, in this case it is overview.md>
  filename: <the name of the target file that get's generated>
  root_message: <the title for the auto-generated file at the root level>
{% endhighlight %}

By default, each file in our collection becomes a (sub)*section in our TOC, so, for our example tree, the following sections get assigned
{% highlight bash %}
_chapters
├── 01_first_chapter      // 1.
|   ├── 00_intro.md       // 1.1
|   ├── 01_content.md     // 1.2
|   └── 02_outro.md       // 1.3
└── 02_second_chapter     // 2.
    ├── 01_end.md         // 2.1
    └── overview.md    
{% endhighlight %}
Note that overview.md did not get section 2.2, but we will focus on that later.

Each page has access to the following variables

 * page.toc.sec: The section numbering
 * page.toc.next: The next page in the table of contents
 * page.toc.prev: The previous page in the table of contents
 * page.toc.children: An array of direct children
 * page.toc.parent: The parent page
 
 Furthermore, by default, TOC will generate an overview page for each directory. In our example, for _chapters (the root overview page) and for 01_first_chapter. This page contains a title together with the table of contents for this (sub)*section. 
 
 
 
 Time to the section (section {{ page.toc.next.toc.sec }} ):  [{{ page.toc.next.title }}]( {{ page.toc.next.url }} )

