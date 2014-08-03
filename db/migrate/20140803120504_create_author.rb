class CreateAuthor < ActiveRecord::Migration
  def change
    create_table :authors do |t|
      t.string :name
      t.timestamps
    end

    change_table :posts do |t|
      t.references :author
    end
  end
end
