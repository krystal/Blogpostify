module Blogpostify
  class Engine < ::Rails::Engine
    
    engine_name 'blogpostify'

    initializer 'blogpostify.initialize' do |app|
      ActiveSupport.on_load :action_controller do
        helper Blogpostify::ViewHelpers
      end
    end
    
  end
end
