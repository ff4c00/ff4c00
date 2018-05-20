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

	# 页面markdown语法及高亮
	class HTMLwithCodeRay < Redcarpet::Render::HTML
  	def block_code(code, language)
    	CodeRay.scan(code, language ||= :ruby).div(:tab_width=>2)
  	end
	end

	def markdown(text)

	  options = {   
	    :autolink => true, 
	    :space_after_headers => true,
			:fenced_code_blocks => true,
	    :no_intra_emphasis => true,
	    :hard_wrap => true,
	    :strikethrough =>true,
			:tables => true
	  }

		renderer = HTMLwithCodeRay.new(:filter_html => true, :hard_wrap => true)

		markdown = Redcarpet::Markdown.new(renderer, options)
	  markdown.render(text).html_safe

	end

	# 页面markdown语法及高亮 end
	

end
