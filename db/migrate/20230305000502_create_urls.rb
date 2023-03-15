class CreateUrls < ActiveRecord::Migration[7.0]
  def change
    create_table :urls do |t|
      t.timestamps
      t.string :short_url, unique: true
      t.string :long_url,  unique: true
    end
  end
end
