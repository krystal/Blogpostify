module Blogpostify
  class Engine < ::Rails::Engine
    
    initializer 'blogpostify.initialize' do |app|
      config.paths["db/migrate"].expanded.each do |expanded_path|
        app.config.paths["db/migrate"] << expanded_path
      end

      ActiveSupport.on_load :action_controller do
        helper Blogpostify::ViewHelpers
      end
    end
    
  end
end
