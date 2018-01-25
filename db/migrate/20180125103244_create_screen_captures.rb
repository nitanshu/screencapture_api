class CreateScreenCaptures < ActiveRecord::Migration[5.0]
  def change
    create_table :screen_captures do |t|
      t.string :service_url
      t.string :file_name

      t.timestamps
    end
  end
end
