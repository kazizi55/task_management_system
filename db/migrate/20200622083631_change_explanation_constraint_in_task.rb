class ChangeExplanationConstraintInTask < ActiveRecord::Migration[5.2]
  def change
    change_column_null :tasks, :explanation, true
  end
end
