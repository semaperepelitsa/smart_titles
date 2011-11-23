require "test_helper"

class SmartTitlesHelperTest < ActionView::TestCase
  def setup
    super
    @av = ActionView::Base.new
    @view_flow = ActionView::OutputFlow.new
    @virtual_path = 'posts/new'
  end

  def teardown
    I18n.backend.reload!
  end


  def test_custom_title
    store_global_title
    store_page_title
    assert_equal "<h1>Hi</h1>", title("Hi")
  end

  def test_translated_title
    store_global_title
    store_page_title
    assert_equal "<h1>New post</h1>", title
  end

  def test_no_page_title
    store_global_title
    assert_nil title
  end

  def test_no_title
    assert_nil title
  end


  def test_head_title_with_custom_title
    store_global_title
    store_page_title
    title("Hi")
    assert_equal "Hi", head_title
  end

  def test_head_title_with_translated_title
    store_global_title
    store_page_title
    assert_equal "New post", head_title
  end

  def test_head_title_with_translated_global_title
    store_global_title
    assert_equal "My Website", head_title
  end

  def test_head_title_with_no_title
    assert_includes head_title, "translation missing: en.title"
  end


  def test_head_title_with_custom_global_title
    assert_equal "Default", head_title("Default")
  end

  def test_head_title_with_custom_global_title_and_custom_title
    title("Hi")
    assert_equal "Hi", head_title("Default")
  end


  def test_head_title_with_template_and_translated_titles
    store_global_title
    store_page_title
    store_title_template
    assert_equal "d New post b", head_title
  end
  # 
  # def test_head_title_with_template_and_custom_title
  #   title_translations
  #   title_template_translation
  #   title("Hi")
  #   assert_equal "d Hi b", head_title
  # end
  # 
  # def test_head_title_with_template_and_translated_title
  #   title_translation
  #   title_template_translation
  #   assert_equal "My Website", head_title
  # end
  # 
  # def test_head_title_with_skipped_template
  #   title_translations
  #   title_template_translation
  #   assert_equal "New post", head_title(template: false)
  # end

private

  def store_translations(*args)
    I18n.backend.store_translations(:en, *args)
  end

  def store_page_title
    store_translations posts: { new: { title: "New post" } }
  end

  def store_titles
    store_global_title
    store_page_title
  end

  def store_global_title
    store_translations title: "My Website"
  end

  def store_title_template
    store_translations title_template: "d %{title} b"
  end

end
