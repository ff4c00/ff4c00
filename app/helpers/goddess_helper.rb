module GoddessHelper

	# 单位换算
	
	def b_to_mb(num:)
		result = conversion_unit(num: num, unit: 1024, sign: '/')
		"#{result}MB"
	end

	# 单位换算 end
	
	private

		# 待优化: 无法保留小数		
		def conversion_unit(num:, unit:, sign:)
			eval("#{num} #{sign} #{unit}")
		end 

end 
