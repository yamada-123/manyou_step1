class AddTaskRefToMiddles < ActiveRecord::Migration[5.2]
  def change
    add_reference :labels,:middle,foreign_key: true
    add_reference :tasks,:middle,foreign_key: true
  end
end
