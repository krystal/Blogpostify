module Blogpostify
  module ViewHelpers

    def blog_posts_for(blog_name, options={}, &block)
      blog = Blogpostify.find_blog!(blog_name)

      if block_given?
        yield blog, get_posts(blog, options)
        return nil # Block should do all of the rendering
      end
    end

    def all_blogs(options={}, &block)
      Blogpostify.blogs.each do |blog|
        yield blog, get_posts(blog, options) if block_given?
      end
      return nil
    end

    private

    def get_posts(blog, options={})
      options.reverse_merge!({
        :count => 3
      })

      blog.posts.asc.limit(options[:count]).to_a
    end

  end
end
