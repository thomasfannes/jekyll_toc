---
title: Auto-generated pages
toc_type: overview
---

#{{ page.toc.sec }} {{ page.title }}

By default, all the non-leaf nodes in our table of contents are auto-generated. These pages contain the table of contents of the section and a title. For the rootnode, the title can be specified by in _data/toc.yml, and for other non-leaf nodes, the title is created as follows:

 1. The trailing numbers together with the underscore are removed from the path
 2. Afterwards, each underscore is converted to a space
 3. And finaly, the first letter is upper cased
 
So in our example, `01_first_chapter` becomes **First chapter**.

If you want to specfiy a non-leaf page yourself, this is possible by putting that file in the section folder and setting the following in the yaml header:
{% highlight yaml %}
---
title: <fill in your title>
toc_type: overview
---
{% endhighlight %}

This way you can specify yourself the title, and what to add on that page. 

