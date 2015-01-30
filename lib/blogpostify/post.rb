module Blogpostify
  class Post < ActiveRecord::Base

    def self.create_from_item(blog_name, post_item)
      post = self.new
      post.blog = blog_name
      post.title = post_item.title
      post.description = truncate_description(post_item.description)
      post.guid = post_item.guid
      post.save
      post
    end

    private

    # Truncate the description to the configured length to the nearest whole word
    def truncate_description(description)
      desc = description[0, Blogpostify.max_description_length]
      desc.split(/\s+/)[0..-2].join(' ')
    end

  end
end
