require 'open-uri'
require 'rss'

require "blogpostify/version"
require "blogpostify/blog"
require "blogpostify/post"
require "blogpostify/view_helpers"
require 'blogpostify/engine'

module Blogpostify

  class BlogNotFoundError < StandardError; end

  class Configuration
    def blogs
      @blogs ||= []
    end

    def add_blog(title, url, options={})
      self.blogs << Blog.new(title, url, options)
    end
  end

  class << self
    attr_accessor :configuration

    def configure
      self.configuration ||= Configuration.new
      yield configuration
    end

    def find_blog!(blog_short_name)
      blog_short_name = blog_short_name.to_s

      found_blog = blogs.find do |blog|
        blog.short_name == blog_short_name
      end

      if found_blog.nil?
        raise BlogNotFoundError, "Blog #{blog_short_name} is not configured. Check Blogpostify#blogs." 
      else
        found_blog
      end
    end

    def blogs
      configuration.blogs
    end

    def update_blogs
      blogs.flat_map do |blog|
        blog.update_posts
      end
    end

    def update_blog(blog_name)
      find_blog!(blog_name).update_posts
    end

  end

end
