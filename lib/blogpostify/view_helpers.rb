module Blogpostify
  module ViewHelpers

    def blog_populated?(blog_name)
      blog = Blogpostify.find_blog!(blog_name)
      blog.posts.exists?
    end

    def blog_posts_for(blog_name, options={}, &block)
      options.reverse_merge!({
        :count => 3
      })

      blog = Blogpostify.find_blog!(blog_name)
      posts_scope = blog.posts.asc.limit(options[:count])

      if block_given?
        posts_scope.each {|post| yield post }
        return nil # Block should do all of the rendering
      else
        posts_scope.to_a
      end
    end

  end
end
