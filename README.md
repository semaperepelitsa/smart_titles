Smart Titles for Rails
===
Provides really convenient way to set up page titles in Rails application.

To specify the page title just add the following line to your view:

    <%= title "Smart Title" %>

This will set up the page title for a browser window and also return the title in `<h1>` tag.
If you don't want to display it inside the page simply remove an equality sign:

    <% title "Title for a browser window" %>
    <h1>Different title for the page</h1>

Installation
---
Add this line to your Gemfile:

    gem 'smart_titles'

And run:

    bundle install

Integration
---
You have to insert the following code inside the `<title>` tag in your layout:

    <title><%= page_title || "Default title" %></title>

The default title is displayed only if you haven't specified the title in your view.
You can also omit `||` operator like this:

    <title><%= page_title "Default title" %></title>

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

Note that even if you don't output it you still have to call it.

    <% title %>

Dynamic titles are set as usual:

    <%= title @page.title %> 

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
Created by Semyon Perepelitsa. See LICENSE.txt for further details.
