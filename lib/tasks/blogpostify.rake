namespace :blogpostify do

  desc 'Poll all configured blogs and update the posts'
  task :update_all => :environment do
    new_posts = Blogpostify.update_blogs
    puts "#{new_posts.count} new posts added"
  end

  desc 'Update the posts for a single blog, pass blog identifier in BLOG'
  task :update => :environment do
    begin 
      new_posts = Blogpostify.update_blog(ENV['BLOG'])
      puts "#{new_posts.count} new posts added"
    rescue Blogpostify::BlogNotFoundError
      puts "Blog #{ENV['BLOG']} is not configured"
    end
  end

end
