class CreateTasks < ActiveRecord::Migration[5.1]
  def change
    create_table :tasks do |t|
      t.string :task
      t.references :user, index: true

      t.timestamps
    end
  end
end
