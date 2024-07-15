class CreateSurveys < ActiveRecord::Migration[7.1]
  def change
    create_table :surveys do |t|
      t.string :name, null: false
      t.text :description
      t.datetime :deleted_at
      t.timestamps
    end
  end
end
