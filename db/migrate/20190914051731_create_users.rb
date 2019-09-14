class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string  :name
      t.date    :date
      t.integer :number
      t.text    :description
      t.timestamps
    end
  end
end
