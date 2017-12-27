class AddDetailsToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :date_of_birth, :datetime
    add_column :users, :avatar, :string
    add_column :users, :phone, :string
    add_column :users, :education, :text
    add_column :users, :work, :text
    add_column :users, :skils, :string
    add_column :users, :social_links, :string
    add_column :users, :about, :text
  end
end
