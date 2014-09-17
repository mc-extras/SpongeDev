# This migration comes from forem (originally 20140917034000)
class AddOrderToCategories < ActiveRecord::Migration
  def change
    add_column :forem_categories, :order, :integer, :default => 0
  end
end
