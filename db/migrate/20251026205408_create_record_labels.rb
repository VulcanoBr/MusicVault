class CreateRecordLabels < ActiveRecord::Migration[7.2]
  def change
    create_table :record_labels do |t|
      t.string :name, null: false # Ex: 'Sony Music', 'Universal Music'
      t.timestamps
    end
    add_index :record_labels, :name, unique: true
  end
end
