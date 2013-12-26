module SmartTitles
  module Helper
    # <title><%= head_title %></title>
    # Will return title if it was set for the current page.
    # Otherwise will return :title translation.
    #
    # <title><%= head_title "My Blog" %></title>
    # The default title will be "My Blog" instead of :title translation.
    #
    # Example usage with title template:
    #     en:
    #       title: The Coolest Store
    #       title_template: %{title} from the Coolest Store
    #
    #     head_title     # => The Coolest Store
    #     title "Drinks" # => <h1>Drinks</h1>
    #     head_title     # => Drinks from the Coolest Store
    def head_title(default_title = t('.title', default: :title))
      if content_for?(:page_title)
        title = content_for(:page_title)
        t('.title_template', title: title, default: [:title_template, title])
      else
        default_title
      end
    end

    # Convinient helper method that will:
    # * Set custom title for the current page if it is passed. Otherwise the title will be automatically set 
    # * Return the title passed or looked up from locale wrapped into h1 tag
    def title(custom_title_or_options = nil)
      case custom_title_or_options
      when Hash
        options = custom_title_or_options
      else
        options = {}
        custom_title = custom_title_or_options
      end

      title = custom_title
      title ||= begin t('.title', options.merge(raise: true))
                rescue I18n::MissingTranslationData
                end

      provide(:page_title, title && title.html_safe) # "provide" already escapes
      content_tag(:h1, title) if title
    end
  end
end
