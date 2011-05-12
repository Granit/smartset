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
    
    create_table :users, :force => true do |t|
      t.string   :login,                     :limit => 40
      t.string   :name,                      :limit => 100, :default => '', :null => true
      t.string   :email,                     :limit => 100
      t.string   :crypted_password,          :limit => 40
      t.string   :salt,                      :limit => 40
      t.datetime :created_at
      t.datetime :updated_at
      t.string   :remember_token,            :limit => 40
      t.datetime :remember_token_expires_at

    end
    add_index :users, :login, :unique => true
    
  end

  def self.down
    drop_table :currencies
    drop_table :countries
    drop_table :monetizations
    drop_table :trips
    drop_table :countries_trips
    drop_table :users
  end
end
