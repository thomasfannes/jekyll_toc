---
title: A few use cases
toc_type: overview
---

# {{ page.toc.nice_sec }} : {{ page.title }}

### Accessing the section number
**input**
{% highlight bash %}
{% raw %}{{page.toc.sec }} {% endraw %}
{% endhighlight %}

**output**
{% highlight bash %}
{{page.toc.sec }}
{% endhighlight %}

### Accessing the section number, together with a small header (e.g. chapter, section)
**input**
{% highlight bash %}
{% raw %}{{page.toc.nice_sec }} {% endraw %}
{% endhighlight %}

**output**
{% highlight bash %}
{{page.toc.nice_sec }}
{% endhighlight %}


### Linking to the parent
**input**
{% highlight yaml %}
{% raw %} [parent]({{ page.toc.up.url }} ) {% endraw %}
{% endhighlight %}

**output**
{% highlight bash %}
[parent]({{ page.toc.up.url }} )
{% endhighlight %}


### Getting the next section reference and title
**input**
{% highlight yaml %}
{% raw %} 
{% if page.toc.next %} 
  {{ page.toc.next.toc.nice_sec }} {{ page.toc.next.title }} 
{% endif %}
{% endraw %}
{% endhighlight %}


**output**
{% highlight yaml %}
{% if page.toc.next %} 
  {{ page.toc.next.toc.nice_sec }} {{ page.toc.next.title }} 
{% endif %}
{% endhighlight %}

### Looping over all the children, and linking to their pages
**input**
{% highlight yaml %}
{% raw %}
<ul>
{% for child in page.toc.children %}
  <li> <a href="{{ child.url }}"> {{child.toc.sec }} {{ child.title }} </a></li>
{% endfor %}
</ul>
{% endraw %}
{% endhighlight %}

**output**
{% highlight yaml %}
<ul>
{% for child in page.toc.children %}
  <li> <a href="{{ child.url }}"> {{child.toc.sec }} {{ child.title }} </a></li>
{% endfor %}
</ul>
{% endhighlight %}


### Generating a table of contents for this section
**input**
{% highlight yaml %}
{% raw %}
{% TOC mode:current depth:-1 %}
{% endraw %}
{% endhighlight %}

**output**
{% highlight yaml %}
{% TOC mode:current depth:-1 %}
{% endhighlight %}

### Generating a table of contents for this collection
**input**
{% highlight yaml %}
{% raw %}
{% TOC mode:chapters depth:-1 %}
{% endraw %}
{% endhighlight %}

**output**
{% highlight yaml %}
{% TOC mode:chapters depth:-1 %}
{% endhighlight %}

### Generating a table of contents for this collection, with depth 2
**input**
{% highlight yaml %}
{% raw %}
{% TOC mode:chapters depth:2 %}
{% endraw %}
{% endhighlight %}

**output**
{% highlight yaml %}
{% TOC mode:chapters depth:2 %}
{% endhighlight %}


Finally, let's look at auto-generated pages, and to not autogenerate them [next]( {{ page.toc.next.url }} )
