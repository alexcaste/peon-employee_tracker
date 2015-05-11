class CreateDivisions < ActiveRecord::Migration
  def change
    create_table(:divisions) do |d|
      d.column(:name, :string)
    end

    create_table(:employees) do |e|
      e.column(:name, :string)
      e.column(:division_id, :int)
    end
  end
end
