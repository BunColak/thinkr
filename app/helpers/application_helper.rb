module ApplicationHelper
  def full_title(page_title="")
    if page_title.empty?
      full_title_name = "Thinkr."
    else
      full_title_name = page_title + " | Thinkr."
    end
  end
end
