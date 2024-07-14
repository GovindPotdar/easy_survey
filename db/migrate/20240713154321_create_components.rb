class CreateComponents < ActiveRecord::Migration[7.1]
  def change
    create_table :components do |t|
      t.string :field, null: false
      t.string :text
      t.decimal :x_axis, null: false, precision: 2
      t.decimal :y_axis, null: false, precision: 2
      t.references :survey, null: false, foreign_key: true

      t.timestamps
    end
  end
end
