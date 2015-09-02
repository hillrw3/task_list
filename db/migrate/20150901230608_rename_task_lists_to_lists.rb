class RenameTaskListsToLists < ActiveRecord::Migration
  def change
    rename_table :task_lists, :lists
  end
end
