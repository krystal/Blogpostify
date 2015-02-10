# Blogpostify

Simple little gem to fetch the latest blog posts from multiple RSS or Atom feeds and cache them in an ActiveRecord model to be displayed in your Rails application.

Blogpostify comes with rake tasks and view helpers to assit with integration into your existing application.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'blogpostify'
```

And then execute:

    $ bundle

Once bundled with your application, run the migration included with the gem:

```sh
bundle exec rake db:migrate
```

## Usage

### Configuration
Add your blog details in an initializer `config/initializers/blogpostify.rb`:

```ruby
Blogpostify.configure do |config|
  config.add_blog("Riding Rails", "http://weblog.rubyonrails.org/feed/atom.xml")
end
```

The title of your blog will be parameterized to form an blog identifier for your cached posts. If you want to set this to something else, set the third parameter. You can also add a path to an icon that represents this blog if you like.

```ruby
Blogpostify.configure do |config|
  config.add_blog("Riding Rails", "http://weblog.rubyonrails.org/feed/atom.xml")
  config.add_blog("Signal v. Noise", "https://signalvnoise.com/posts.rss", "svn", "https://basecamp.com/assets/general/basecamp.png")
end
```

Okay, great! You're all ready to start fetching blog posts.

### Updating

For your convenience we've included a couple of rake tasks to assist with updating blog posts. Feel free to use these in conjunction with `cron` to update your posts, if you're using something like `clockwork` to schedule tasks, we'll look at that in a second.

`blogpostify:update_all` will go through each configured blog and attempt to fetch new posts for them:

```sh
bundle exec rake blogpostify:update_all
=> 2 new posts added
```

`blogpostify:update` can be used to just update a single blog, pass BLOG as an environment variable to specifty the blog:

```sh
bundle exec rake blogpostify:update BLOG=svn
=> 4 new posts added
```

So what if you're using something like `clockwork` or another ruby based worker to run your scheduled task? No problem. To update all blogs simply run:

```ruby
Blogpostify.update_blogs
=> [#<Blogpostify::Post...]
```

Just want to update one blog? No problem:

```ruby
Blogpostify.update_blog('svn')
=> [#<Blogpostify::Post...]
```

If we can't find the blog specified in the configuration you'll recieve a Blogpostify::BlogNotFound error.

### Displaying Entries

There are a couple of helpers included to assist you in displaying your post entries in your app. `blog_populated?` allows you to check if any blog posts have been fetched for a blog yet. `blog_posts_for` fetches the most recent posts for a particular blog, sorted by published date. Lets have a look at these in practice in `app/views/dashboard/index.html.haml`:

```haml
- if blog_populated?('svn')
  %h4 Latest News
  %ul.blog-posts
  = blog_posts_for('svn', :count => 1) do |post|
    %li.post
      %span.title= post.title
      %span.description= truncate post.description, :length => 90
      %span.published= post.published_at.strftime("%-d %b %H:%M")
      %span.link= link_to "Read More...", post.link
```

Note that you can optionally pass `count` to `blog_posts_for` to only get the n-latest posts. By default this is 3.
