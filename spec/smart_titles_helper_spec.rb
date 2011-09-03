require File.expand_path('spec_helper', File.dirname(__FILE__))

describe SmartTitles::Helper do
  include ActionView::Helpers

  before do
    @virtual_path = 'posts/new'
    I18n.backend.reload!
  end

  def store_translations(*args)
    I18n.backend.store_translations(:en, *args)
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

      describe 'with :title_template' do
        it "used for page_title" do
          store_translations title_template: "d %{title} b"
          title("New post")
          head_title.should == "d New post b"
        end

        it "is skipped for custom title" do
          store_translations title_template: "d %{title} b"
          head_title("Default").should == "Default"
        end

        it "is skipped if template: false" do
          store_translations title_template: "d %{title} b"
          title("New post")
          head_title("Default", template: false).should == "New post"
        end
      end
    end
  end

  describe 'i18n' do
    describe '#title' do
      it "returns .title wrapped in h1 tag if there are :title and .title" do
        store_translations title: "My Website", posts: { new: { title: "New post" } }
        title.should == "<h1>New post</h1>"
      end

      it "returns .title wrapped in h1 tag if there is only .title" do
        store_translations posts: { new: { title: "New post" } }
        title.should == "<h1>New post</h1>"
      end

      it "returns nothing if there is no .title" do
        store_translations title: "My Website"
        title.should == nil
      end

      it "returns nothing if there are no translations" do
        title.should == nil
      end
    end

    describe '#head_title' do
      it "returns .title if there are :title and .title" do
        store_translations title: "My Website", posts: { new: { title: "New post" } }
        head_title.should == "New post"
      end

      it "returns .title if there is only .title" do
        store_translations posts: { new: { title: "New post" } }
        head_title.should == "New post"
      end

      it "returns :title if there is no .title" do
        store_translations title: "My Website"
        head_title.should == "My Website"
      end

      it "returns missing translation if there are no tranlations" do
        head_title.should include("translation missing: en.title")
      end

      it "returns custom title" do
        store_translations title: "My Website"
        head_title("Custom").should == "Custom"
      end

      it "returns .title even if custom default title is passed" do
        store_translations posts: { new: { title: "New post" } }
        head_title("Custom").should == "New post"
      end

      describe 'with :title_template' do
        it "used for page_title" do
          store_translations title_template: "d %{title} b", posts: { new: { title: "New post" } }
          head_title.should == "d New post b"
        end

        it "is skipped for default title" do
          store_translations title: "My Website", title_template: "d %{title} b"
          head_title.should == "My Website"
        end

        it "is skipped if template: false" do
          store_translations title_template: "d %{title} b", posts: { new: { title: "New post" } }
          head_title(template: false).should == "New post"
        end
      end
    end
  end
end
