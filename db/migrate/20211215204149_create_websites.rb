class CreateWebsites < ActiveRecord::Migration[6.1]
  def change
    create_table :websites do |t|
      t.text :url, reqiuire: true
      t.string :title
      t.integer :visits, default: 0

      t.timestamps
    end
  end
end
