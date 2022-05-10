class RemoveUsernameFromRestaurants < ActiveRecord::Migration[6.1]
  def change
    remove_column :restaurants, :github_name, :string
  end
end
