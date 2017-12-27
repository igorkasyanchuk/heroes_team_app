class AddDetailsToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :date_of_birth, :datetime
    add_column :users, :avatar, :string
    add_column :users, :phone, :string
    add_column :users, :education, :string
    add_column :users, :work, :string
    add_column :users, :social_link, :string
    add_column :users, :about_yourself, :string
  end
end
