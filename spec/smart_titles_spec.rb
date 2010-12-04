require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "SmartTitles" do
  include ActionView::Helpers
  include SmartTitlesHelper
  
  it "#title sets up and #page_title returns the title" do
    title 'Hello World!'
    page_title.should == 'Hello World!'
  end
  
  it "#title returns the title in h1 tag" do
    title('Hello World!').should == '<h1>Hello World!</h1>'
  end
end
