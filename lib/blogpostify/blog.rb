module Blogpostify
  class Blog

    attr_accessor :title, :url, :icon, :short_name

    def update_posts
      open(self.url) do |body|
        rss = RSS::Reader.parse(body)
        rss.items.each do |post|
          post = Post.create_from_item(self.short_name, post)
        end
      end
    end

    def posts
      Post.where(:blog => self.short_name)
    end

  end
end
