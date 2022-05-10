class AddUsernameToRestaurants < ActiveRecord::Migration[6.1]
  def change
    add_column :restaurants, :github_name, :string
  end
end
