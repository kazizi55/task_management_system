class CreateLabelTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :label_tasks do |t|
      t.references :task, index: true
      t.references :label, index: true, foreign_key: true

      t.timestamps
    end
  end
end
