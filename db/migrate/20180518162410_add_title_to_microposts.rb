class AddTitleToMicroposts < ActiveRecord::Migration[5.0]
  def change
    add_column :microposts, :title, :string, content: '文章标题'
    add_index :microposts, :title
  end
end
