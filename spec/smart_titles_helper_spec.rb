require File.expand_path('spec_helper', File.dirname(__FILE__))

describe SmartTitles::Helper do
  include ActionView::Helpers

  before do
    @sample = 'Hello World!'
  end

  describe '#page_title' do
    it 'returns the title set by #title' do
      title(@sample)
      page_title.should == @sample
    end
  end

  describe '#title' do
    it 'returns the title in h1 tag' do
      title(@sample).should == "<h1>#{@sample}</h1>"
    end
  end
end
