class AddProjectTable < ActiveRecord::Migration
  def change
    create_table(:projects) do |p|
      p.column(:name, :string)
      p.column(:done, :boolean)
  end

    add_column(:employees, :project_id, :int)
  end
end
