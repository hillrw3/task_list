class RenameTaskListIdToListId < ActiveRecord::Migration
  def change
    rename_column :tasks, :task_list_id, :list_id
  end
end
