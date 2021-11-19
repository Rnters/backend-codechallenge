class CreateApiKeys < ActiveRecord::Migration[6.1]
  def change
  	if !table_exists? 'api_keys'
	    create_table :api_keys do |t|
	      t.string :access_token, :unique => true

	      t.timestamps
	    end
	end
  end
end
