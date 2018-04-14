class AddAdminToUsers < ActiveRecord::Migration[5.0]
  def change
		# 类型为布尔值的字段,Active Record会自动生成一个'字段名?'的布尔值方法
		# 所以布尔值字段admin,就自动拥有了返回布尔值的admin?方法
		# toggle!方法用于对布尔值属性进行取反操作,如:
		# 对象.toggle!(:布尔值属性名称)
		# 调用后自动保存修改内容,即不用调用save方法
    add_column :users, :admin, :boolean, default: false
  end
end
