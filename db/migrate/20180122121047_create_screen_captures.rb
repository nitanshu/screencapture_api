class CreateScreenCaptures < ActiveRecord::Migration[5.0]
  def change
    create_table :screen_captures do |t|

      t.timestamps
    end
  end
end
