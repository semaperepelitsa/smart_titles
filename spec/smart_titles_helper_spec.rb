require File.expand_path('spec_helper', File.dirname(__FILE__))

describe SmartTitles::Helper do
  include ActionView::Helpers

  before do
    @virtual_path = 'posts/new'
  end

  describe 'no i18n' do
    describe '#title' do
      it "sets #page_title" do
        title("Hi")
        page_title.should == "Hi"
      end

      it "returns h1-wrapped title" do
        title("Hi").should == "<h1>Hi</h1>"
      end
    end

    describe '#page_title' do
      it "returns nil if no title was set" do
        page_title.should == nil
      end
    end

    describe '#head_title' do
      it 'returns #page_title if it was set' do
        title("Hi")
        head_title.should == "Hi"
      end

      it "returns missing translation if no title was set" do
        head_title.should include("translation missing: en.title")
      end

      it "returns title passed if no title was set" do
        head_title("Default").should == "Default"
      end
    end
  end

  # describe 'i18n' do
  #   def store_translations(*args)
  #     I18n.backend.store_translations(:en, *args)
  #   end
  # 
  #   before do
  #     @virtual_path = 'posts/new'
  #     I18n.backend.reload!
  #   end
  # 
  #   describe '#title' do
  #     it "sets translated .title" do
  #       store_translations posts: { new: { title: "New post" } }
  #       title.should == "<h1>New post</h1>"
  #       page_title.should == "New post"
  #     end
  # 
  #     it "falls back to :title if there is no .title" do
  #       store_translations title: "My Website"
  #       title.should be_blank
  #       page_title.should == "My Website"
  #     end
  # 
  #     it "sets nil title when no translated titles" do
  #       title.should be_blank
  #       page_title.should == nil
  #     end
  #   end
  # 
  #   describe '#page_title' do
  #     it "returns :title if title wasn't set" do
  #       store_translations title: "My Website"
  #       page_title.should == "My Website"
  #     end
  # 
  #     it "returns nil if title wasn't set and there is no :title" do
  #       page_title.should == nil
  #     end
  # 
  #     it "returns .title even if #title wasn't called" do
  #       store_translations posts: { new: { title: "New post" } }
  #       page_title.should == "New post"
  #     end
  #   end
  # end
end
