class CreateVenues < ActiveRecord::Migration[5.2]
  def change
    create_table :venues do |t|
      enable_extension 'hstore' unless extension_enabled?('hstore')
      t.string :name
      t.hstore :address_info, default:{
        latitude:nil,
        longitude:nil
      }
      t.hstore :box_office_info, default:{}
      t.text :images,array: true, default: []

      t.timestamps
    end
  end
end
