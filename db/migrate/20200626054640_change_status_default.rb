class ChangeStatusDefault < ActiveRecord::Migration[5.2]
  def change
    change_column_default :tasks, :status, 0
  end
end
