class CreateSearches < ActiveRecord::Migration[5.1]
  def change
    create_table :searches do |t|
      t.string :term
      t.references :user, foreign_key: true
    end
  end
end
