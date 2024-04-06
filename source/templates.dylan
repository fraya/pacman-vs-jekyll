Module: pacman-vs-jekyll-impl

define constant $template-404
  = """---
layout: default
---

<style type="text/css" media="screen">
  .container {
    margin: 10px auto;
    max-width: 600px;
    text-align: center;
  }
  h1 {
    margin: 30px 0;
    font-size: 4em;
    line-height: 1;
    letter-spacing: -1px;
  }
</style>

<div class="container">
  <h1>404</h1>

  <p><strong>Page not found :(</strong></p>
  <p>The requested page could not be found.</p>
</div>
""";

define constant $template-config
  = """title: Opendylan Package Catalog
email: dylan-lang@googlegroups.com
description: >- # this means to ignore newlines until "baseurl:"
  Opendylan Package Catalog
baseurl: "/pacman-catalog" # the subpath of your site, e.g. /blog
url: "https://dylan-lang.github.io"
twitter_username: DylanLanguage
github_username: dylan-lang

# Build settings
markdown: kramdown
theme: minima

collections:
  packages:
    output: true
""";

define constant $template-index
  = """---
layout: home
---
<dl>
{%% for package in site.packages %%}
  <dt>
    <a href="{{ package.url | prepend: site.baseurl }}">
      {{ package.name }}
    </a>
  </dt>
  <dd> {{ package.description | markdownify }} </dd>
{%% endfor %%}
</dl>    
""";							   

define constant $template-package
  = """---
layout: post
name: %s
---
<p> %s </p>
""";

define constant $template-gemfile
  = """source "https://rubygems.org"
gem "minima", "~> 2.5"
gem "github-pages", group: :jekyll_plugins
# If you have any plugins, put them here!
group :jekyll_plugins do
  gem "jekyll-feed", "~> 0.12"
end

# Windows and JRuby does not include zoneinfo files, so bundle the tzinfo-data gem
# and associated library.
platforms :mingw, :x64_mingw, :mswin, :jruby do
  gem "tzinfo", ">= 1", "< 3"
  gem "tzinfo-data"
end

# Performance-booster for watching directories on Windows
gem "wdm", "~> 0.1.1", :platforms => [:mingw, :x64_mingw, :mswin]

# Lock `http_parser.rb` gem to `v0.6.x` on JRuby builds since newer versions of the gem
# do not have a Java counterpart.
gem "http_parser.rb", "~> 0.6.0", :platforms => [:jruby]
""";
