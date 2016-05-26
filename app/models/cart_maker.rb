class CartMaker

  attr_reader :items, :properties

  def initialize(item_ids)
    @items = get_items(item_ids) # want items to be an array of json item objects
    @properties = make_cart(item_ids)
  end

  def get_items(ids)
    item_maker = UltracartService.new
    items = ids.map do |id|
      Item.new(item_maker.get_item(id))
    end
  end

  def make_cart(ids)
    cart = UltracartService.new
    items = ids.map do |id|
      cart.get_item(id)
    end
    Cart.new(cart.add_item(items))
  end
  
end
