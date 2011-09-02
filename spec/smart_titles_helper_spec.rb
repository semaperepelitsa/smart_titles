require File.expand_path('spec_helper', File.dirname(__FILE__))

describe SmartTitles::Helper do
  include ActionView::Helpers

  before do
    @sample = 'Hello World!'
  end

  describe 'no i18n' do
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

  describe 'i18n' do
    def store_translations(*args)
      I18n.backend.store_translations(:en, *args)
    end

    before do
      @virtual_path = 'posts/new'
      I18n.backend.reload!
    end

    describe '#title' do
      it "sets translated .title" do
        store_translations posts: { new: { title: "New post" } }
        title.should == "<h1>New post</h1>"
        page_title.should == "New post"
      end

      it "falls back to :title if there is no .title" do
        store_translations title: "My Website"
        title.should be_blank
        page_title.should == "My Website"
      end

      it "sets nil title when no translated titles" do
        title.should be_blank
        page_title.should == nil
      end
    end

    describe '#page_title' do
      it "returns :title if title wasn't set" do
        store_translations title: "My Website"
        page_title.should == "My Website"
      end

      it "returns nil if title wasn't set and there is no :title" do
        page_title.should == nil
      end
    end
  end
end
