class CreateScrapResults < ActiveRecord::Migration[5.2]
  def change
    create_table :scrap_results do |t|
      t.string  :city
      t.string :pid
      t.string :post_url
      t.datetime :datetime
      t.string :title
      t.text :content

      t.timestamps
    end
  end
end
