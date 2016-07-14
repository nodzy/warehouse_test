Sequel.migration do
  up do
    create_table(:basket_items) do
      primary_key :id
      String :name, null: false
      Numeric :price, null: false
      Text :description, null: false
    end
  end

  down do
    drop_table(:basket_items)
  end
end
