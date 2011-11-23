module SmartTitles
  class Railtie < Rails::Railtie

    initializer "smart_titles.helper" do
      ActiveSupport.on_load :action_view do
        include SmartTitles::Helper
      end
    end

  end
end
