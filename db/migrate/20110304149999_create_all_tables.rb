class CreateAllTables < ActiveRecord::Migration
  def self.up
    create_table :currencies, :force => true do |t|
      t.string   :name
	  t.string   :currencycode
      t.timestamps
    end
    
    create_table :countries, :force => true do |t|
      t.string :name
      t.string :countrycode
	  t.boolean :visited
      t.timestamps
    end
    
	create_table :countries_currencies, :id => false do |t|
      t.column :country_id, :integer
      t.column :currency_id, :integer
    end

  end

  def self.down
    drop_table :currencies
    drop_table :countries
    drop_table :countries_currencies
  end
end
