---
title: A few use cases
---

# {{ page.toc.sec }} {{ page.title }}

### Accessing the section number
{% highlight bash %}
{% raw %}{{page.toc.sec }} {% endraw %}
{% endhighlight %}


### Setting a link to the parent
{% highlight yaml %}
{% raw %} [parent]({{ page.toc.parent.url }} ) {% endraw %}
{% endhighlight %}


### Getting the next section reference and title
{% highlight yaml %}
{% raw %} 
{% if page.toc.next %} 
  {{ page.toc.next.toc.sec }} {{ page.toc.next.title }} 
{% endif %}
{% endraw %}
{% endhighlight %}


### Looping over all the children, and linking to their pages

{% highlight yaml %}
{% raw %}
<ul>
{% for child in page.toc.children %}
  <li> <a href="{{ child.url }}"> {{child.toc.sec }} {{ child.title }} </a></li>
{% endfor %}
</ul>
{% endraw %}
{% endhighlight %}


### Generating a table of contents for this section
{% highlight yaml %}
{% raw %}
{% TOC mode:current depth:-1 %}
{% endraw %}
{% endhighlight %}


### Generating a table of contents for this section with depth 2
{% highlight yaml %}
{% raw %}
{% TOC mode:current depth:2 %}
{% endraw %}
{% endhighlight %}

### Generating a table of contents for the root
{% highlight yaml %}
{% raw %}
{% TOC mode:global depth:-1 %}
{% endraw %}
{% endhighlight %}


Finally, let's look at auto-generated pages, and to not autogenerate them [next]( {{ page.toc.next.url }} )
