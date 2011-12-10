Smart Titles for Rails
===
Provides really convenient way to set up page titles in Rails application.

To specify the page title just add the following line to your view:

    <%= title "Smart Title" %>

This will set up the page title for a browser window and also return the title in `<h1>` tag.
If you don't want to display it inside the page simply remove an equality sign:

    <% title "Title for a browser window" %>
    <h1>Different title for the page</h1>

This gem is under development and [therefore](http://semver.org/) API can change between minor versions until the 1.0.0.
It works only with Rails 3.1.

Installation
---
Add this line to your Gemfile:

    gem 'smart_titles', '~> 0.3.0'

And run:

    bundle install

Integration
---
You have to insert the following code inside the `<title>` tag in your layout:

    <title><%= head_title "Default title" %></title>

The default title is displayed only if you haven't specified title in your view.

With Internationalization
---
If you are using I18n in your Rails application static titles are specified in the locale file:

    en:
      title: Default title
      pages:
        index:
          title: All pages
        new:
          title: Create a page

And then you should just call `title` without any arguments.

    <%= title %>

Note that you _have to call it_ even if you don't output it.

    <% title %>

Dynamic titles are set as usual:

    <%= title @page.title %>

"Default title" will be only used by `head_title` if you call it with no arguments and there will be no title set by the current page.

    <title><%= head_title %></title>

Title Template
---
If you want to add your website name to all of your titles just add :title_template translation

    en:
      title: The Coolest Store
      title_template: %{title} from the Coolest Store
      products:
        index:
          title: Products

And now products#index page will have "Products from the Coolest Store" browser's title. However, `<%= title %>` will still output `<h1>Products</h1>`.

Changelog
---
### 0.3.0
* Important change in the documentation: you have to call `title` with no arguments when you want to use translated title.
* Fixed bug when `head_title` returned default title even if there was a custom title in locale.
* Added actual Railtie class for reliable integration. This fixes a problem when sometimes helper wasn't included for some reason.
* Internal changes that you probably don't care about.
  * There are now only 2 public helper methods: `title` and `head_title`.
  * All helper methods are documented.
  * Missing translation is now detected more safely.

### 0.2.0
* `page_title` renamed to `head_title`.
* Added support for :title_template translation

Contributing
---
* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it
* Fork the project
* Start a feature/bugfix branch
* Commit and push until you are happy with your contribution
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

Copyright
---
Created by Semyon Perepelitsa. Distributed under MIT license. See License.txt for further details.
