class AddUsernameToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :github_name, :string
  end
end
