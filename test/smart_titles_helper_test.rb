require "test_helper"

class SmartTitlesHelperTest < ActionView::TestCase
  def setup
    super
    @av = ActionView::Base.new
    @view_flow = ActionView::OutputFlow.new
    @virtual_path = 'posts/new'
    I18n.backend.reload!
  end

  def store_translations(*args)
    I18n.backend.store_translations(:en, *args)
  end

  def page_title_translation
    store_translations posts: { new: { title: "New post" } }
  end

  def title_translation
    store_translations title: "My Website"
  end

  def title_translations
    page_title_translation
    title_translation
  end

  def title_template_translation
    store_translations title_template: "d %{title} b"
  end


  def test_page_title_with_custom_title
    title_translations
    title("Hi")
    assert_equal "Hi", page_title
  end

  def test_page_title_with_translated_title
    title_translations
    assert_equal "New post", page_title
  end

  def test_page_title_with_no_title
    assert_nil page_title
  end


  def test_custom_title
    title_translations
    assert_equal "<h1>Hi</h1>", title("Hi")
  end

  def test_translated_title
    title_translations
    assert_equal "<h1>New post</h1>", title
  end

  def test_no_page_title
    title_translation
    assert_nil title
  end

  def test_no_title
    assert_nil title
  end


  def test_head_title_with_custom_title
    title_translations
    title("Hi")
    assert_equal "Hi", head_title
  end

  def test_head_title_with_translated_titles
    title_translations
    assert_equal "New post", head_title
  end

  def test_head_title_with_translated_page_title
    page_title_translation
    assert_equal "New post", head_title
  end

  def test_head_title_with_translated_title
    title_translation
    assert_equal "My Website", head_title
  end

  def test_head_title_with_no_title
    assert_includes head_title, "translation missing: en.title"
  end


  def test_head_title_with_template_and_translated_titles
    title_translations
    title_template_translation
    assert_equal "d New post b", head_title
  end

  def test_head_title_with_template_and_custom_title
    title_translations
    title_template_translation
    title("Hi")
    assert_equal "d Hi b", head_title
  end

  def test_head_title_with_template_and_translated_title
    title_translation
    title_template_translation
    assert_equal "My Website", head_title
  end

  def test_head_title_with_skipped_template
    title_translations
    title_template_translation
    assert_equal "New post", head_title(template: false)
  end
end
