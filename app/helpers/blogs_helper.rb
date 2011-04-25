module BlogsHelper
  def html_helpers(text)
    return_text = text.gsub(/\[img\[/, "<img src=")
  end
end
