class AddPasswordDigestToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :password_digest, :string, comment: "存储安全的密码哈希值"
  end
end
