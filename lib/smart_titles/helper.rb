module SmartTitles
  module Helper
    MISSING_TRANSLATION = 0

    def page_title(default = nil)
      title if @page_title.nil?
      @page_title != MISSING_TRANSLATION ? @page_title : default
    end

    def title(str = nil)
      if str.nil?
        str = t('.title')
        @page_title = t('.title', :default => [:title, MISSING_TRANSLATION])
      else
        @page_title = str
      end
      content_tag(:h1, str)
    end
  end
end
