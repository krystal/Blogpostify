require 'open-uri'
require 'rss'

require "blogpostify/version"
require "blogpostify/blog"
require "blogpostify/post"

module Blogpostify

  attr_reader :blogs
  attr_accessor :max_description_length

  # Maximum length a description can be in characters
  def max_description_length
    @max_description_length || 200
  end

end
