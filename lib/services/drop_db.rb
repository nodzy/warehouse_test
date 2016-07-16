require 'sequel'
module Shop
  class DropDatabase
    def call
      items = DB[:products]
      items.delete
    end
  end
end
