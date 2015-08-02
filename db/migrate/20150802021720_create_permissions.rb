class CreatePermissions < ActiveRecord::Migration
  def change
    create_table :permissions do |t|
      t.string :name, null: false
      t.timestamps null: false
    end
  end
end
