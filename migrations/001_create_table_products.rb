Sequel.migration do
  up do
    create_table(:products) do
      primary_key :id
      String :name, null: false
      Numeric :price, null: false
      Text :description, null: false
    end
  end

  down do
    drop_table(:products)
  end
end
