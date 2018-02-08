class AddSiteToSearches < ActiveRecord::Migration[5.1]
  def change
    add_column :searches, :site, :string
  end
end
