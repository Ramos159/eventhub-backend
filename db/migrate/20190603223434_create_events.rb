class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      enable_extension 'hstore' unless extension_enabled?('hstore')
      t.string :name
      t.boolean :on_sale
      t.hstore :classifications, default:{}
      t.text :images,array: true, default: []

      t.timestamps
    end
  end
end
