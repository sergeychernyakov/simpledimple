class CreateShortUrls < ActiveRecord::Migration[5.2]
  def change
    create_table :short_urls do |t|
      t.string :identifier
      t.string :long_url
      t.integer :clicks_count, default: 0
      t.timestamps
    end
  end
  
end