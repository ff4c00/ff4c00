module ApplicationHelper
  
	include GoddessHelper

  def full_title(page_title = '')
    base_title = 'ff4c00'

    if page_title.empty?
      base_title
    else
      "#{page_title} | #{base_title}"
    end

  end

  def blank_div(div_class:)
    "<div class=#{div_class}></div>".html_safe
  end

  def button_text(text: '提交')
    provide(:button_text, text)
  end

end
