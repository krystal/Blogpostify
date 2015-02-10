module Blogpostify
  class Blog

    attr_accessor :title, :url, :short_name, :icon, :homepage

    def initialize(title, url, options={})
      self.title = title
      self.url = url
      self.short_name = options[:short_name]
      self.icon = options[:icon]
      self.homepage = options[:homepage]
    end

    def update_posts
      created = []

      open(self.url) do |body|
        rss = RSS::Parser.parse(body)
        rss.items.each do |post|
          post = Post.create_from_item(self.short_name, post)

          # Post not saved if guid is already registered for this blog
          created << post if post.persisted? 
        end

        created
      end
    end

    def posts
      Post.where(:blog_id => self.short_name).asc
    end

    def populated?
      posts.exists?
    end

    def short_name
      @short_name ||= title.parameterize
    end

  end
end
