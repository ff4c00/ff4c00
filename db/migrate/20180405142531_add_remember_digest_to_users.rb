class AddRememberDigestToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :remember_digest, :string, comment: '记忆令牌哈希摘要'
  end
end
