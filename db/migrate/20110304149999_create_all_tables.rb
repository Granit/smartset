class CreateAllTables < ActiveRecord::Migration
  def self.up
    create_table :currencies, :force => true do |t|
      t.string   :name
	  t.string   :currencycode
	  t.boolean  :collected
      t.timestamps
    end
    
    create_table :countries, :force => true do |t|
      t.string :name
      t.string :countrycode
	  t.boolean :visited
      t.timestamps
    end
 
	create_table :monetizations do |t|
      t.column :country_id, :integer
      t.column :currency_id, :integer
	  t.column "visited_numbers",  :integer
	  t.column "visited", :boolean
    end

    create_table :trips, :force => true do |t|
      t.string :description
      t.datetime :date
	  t.string :status
      t.timestamps
    end
    
	create_table :countries_trips, :id => false do |t|
      t.column :country_id, :integer
      t.column :trip_id, :integer
    end
  end

  def self.down
    drop_table :currencies
    drop_table :countries
    drop_table :monetizations
    drop_table :trips
    drop_table :countries_trips
  end
end
