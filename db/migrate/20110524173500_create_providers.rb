class CreateProviders < ActiveRecord::Migration
  def self.up
    create_table :providers do |t|
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :providers
  end
end
