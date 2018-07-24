class CreateMatches < ActiveRecord::Migration[5.0]
  def change
    create_table :matches do |t|
      t.string :host
      t.string :guest
      t.string :score, limit: 5
      t.date :date

      t.timestamps
    end
  end
end
