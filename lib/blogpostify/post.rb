module Blogpostify
  class Post < ActiveRecord::Base

    self.table_name = 'blogpostify_posts'

    scope :asc, -> { order(:published_at).reverse_order }

    validates :guid, :uniqueness => { :scope => :blog_id }

    class << self

      include ActionView::Helpers::SanitizeHelper

      def create_from_item(blog_name, post_item)
        post = self.new
        post.blog_id = blog_name
        post.title = post_item.title
        post.description = sanitize_description(post_item.description)
        post.guid = post_item.guid.content.to_s
        post.published_at = post_item.pubDate
        post.link = post_item.link
        post.save
        post
      end

      private

      # Truncate the description to the configured length to the nearest whole word
      def sanitize_description(description)
        ActionController::Base.helpers.strip_tags(description)
      end
    end

    def blog
      @blog ||= Blogpostify.find_blog!(self.blog_id)
    end

  end
end
