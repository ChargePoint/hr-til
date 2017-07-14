class AddGithubHandleToDeveloper < ActiveRecord::Migration[5.0]
  def change
    add_column :developers, :github_handle, :string
  end
end
