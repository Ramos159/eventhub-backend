class CreateVenueEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :venue_events do |t|
      enable_extension 'hstore' unless extension_enabled?('hstore')
      t.references :event, foreign_key: true
      t.references :venue, foreign_key: true
      t.hstore :sale_info, default:{}
      t.hstore :pricing_info, default:{}
      t.hstore :event_info, default:{}

      t.timestamps
    end
  end
end
