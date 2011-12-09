module SmartTitles
  MISSING_TRANSLATION = Object.new

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
    def head_title(default_title = t(:title))
      if title = page_title
        t(:title_template, title: title, default: title)
      else
        default_title
      end
    end

    # Convinient helper method that will:
    # * Set custom title for the current page if it is passed. Otherwise the title will be automatically set 
    # * Return the title passed or looked up from locale wrapped into h1 tag
    def title(custom_title = nil)
      provide(:page_title, custom_title)
      content_tag(:h1, page_title) if page_title
    end

  private

    # This is a page title that was set by the #title helper method
    # It defaults to ".title" translation
    def page_title
      if content_for?(:page_title)
        content_for(:page_title)
      else
        translation = t('.title', default: MISSING_TRANSLATION)
        translation unless translation.equal? MISSING_TRANSLATION
      end
    end
  end
end
