module SmartTitles
  module Helper
    MISSING_TRANSLATION = 0

    def head_title(custom_default_title = nil)
      page_title || custom_default_title || default_title
    end

    attr_writer :page_title

    def page_title
      @page_title || default_page_title
    end

    def title(new_title = nil)
      self.page_title = new_title if new_title
      content_tag(:h1, page_title) if page_title
    end

    def default_page_title
      translation = t('.title', default: MISSING_TRANSLATION)
      translation unless translation == MISSING_TRANSLATION
    end

    def default_title
      t(:title)
    end
  end
end
