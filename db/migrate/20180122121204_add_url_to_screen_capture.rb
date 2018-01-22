class AddUrlToScreenCapture < ActiveRecord::Migration[5.0]
  def change
    add_column :screen_captures, :url, :string
  end
end
