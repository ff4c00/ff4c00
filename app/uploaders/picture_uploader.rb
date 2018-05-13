# encoding: utf-8

class PictureUploader < CarrierWave::Uploader::Base


  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick

	# 上传图像最大尺寸限制
	process resize_to_limit: Goddess.picture.max_width_and_height

  # Choose what kind of storage to use for this uploader:
	# 生产环境中部分情况存储的文件都是临时的
	# 代码重新部署会导致临时文件丢失
	# 所以要将图像与应用所在的文件系统分开
	# 待实现: 云存储
	unless Rails.env.production? && Goddess.use_fog
  	storage :file
	else
  	storage :fog
	end

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process :scale => [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  # version :thumb do
  #   process :resize_to_fit => [50, 50]
  # end

	# 图片
	def extension_white_list
		Goddess.picture.extension_white_list
	end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

end
