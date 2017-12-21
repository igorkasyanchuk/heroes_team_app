class AddCompanyRefToIndustries < ActiveRecord::Migration[5.1]
  def change
  	add_reference :industries, :company, foreign_key: true
  end
end
