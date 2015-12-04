class CreateCharges < ActiveRecord::Migration
  def change
    create_table :charges do |t|

      t.timestamps null: false
      t.references :user, index: true, foreign_key: true
    end
  end
end
