require 'test_helper'

class HtmlFormatTest < ActiveSupport::TestCase
  setup do
    HtmlFormat.default_options[:table_class] = nil
  end

  test "html_format" do
    assert_nil html_format(nil)
    assert_equal "<div class=\"html_format html_format_depth_0\"><table class=\"table html_format_type_object\"><tbody><tr><td>1</td></tr></tbody></table></div>", html_format(1)
  end

  test "to_html" do
    assert_equal "<div class=\"html_format html_format_depth_0\"><table class=\"table html_format_type_object\"><tbody><tr><td>1</td></tr></tbody></table></div>", 1.to_html
    assert_nil [].to_html
    assert_nil "".to_html
  end

  test "array of hash" do
    v = [
      {id: 1, name: "alice", created_at: "2000-01-01"},
      {id: 2, name: "bob",   created_at: "2000-01-02"},
      {id: 3, name: "carol", created_at: "2000-01-03"},
    ]
    assert_equal "<div class=\"html_format html_format_depth_0\"><table class=\"table html_format_type_array_of_hash\"><thead><tr><th>id</th><th>name</th><th>created_at</th></tr></thead><tbody><tr><td>1</td><td>alice</td><td>2000-01-01</td></tr><tr><td>2</td><td>bob</td><td>2000-01-02</td></tr><tr><td>3</td><td>carol</td><td>2000-01-03</td></tr></tbody></table></div>", v.to_html
  end

  test "hash"do
    v = {id: 1, name: "alice", created_at: "2000-01-01"}
    assert_equal "<div class=\"html_format html_format_depth_0\"><table class=\"table html_format_type_hash\"><tr><th>id</th><td>1</td></tr><tr><th>name</th><td>alice</td></tr><tr><th>created_at</th><td>2000-01-01</td></tr></table></div>", v.to_html
  end

  test "array of array" do
    v = [
      [1, 2, 3],
      [4, 5, 6],
      [7, 8, 9],
    ]
    assert_equal "<div class=\"html_format html_format_depth_0\"><table class=\"table html_format_type_array_of_array\"><tbody><tr><td>1</td><td>2</td><td>3</td></tr><tr><td>4</td><td>5</td><td>6</td></tr><tr><td>7</td><td>8</td><td>9</td></tr></tbody></table></div>", v.to_html
  end

  test "array" do
    assert_equal "<div class=\"html_format html_format_depth_0\"><table class=\"table html_format_type_array\"><tbody><tr><td>0</td><td>1</td><td>2</td><td>3</td></tr></tbody></table></div>", [0, 1, 2, 3].to_html
  end
end
