module NavBar
  extend ActiveSupport::Concern

  def set_stores
    @stores ||= Store.all
  end

  def set_inventories
    @inventories ||= Inventory.all
  end
end
