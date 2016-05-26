class CartMaker

  attr_reader :items, :properties

  def initialize(item_ids)
    @ids = item_ids
    if @ids.nil?
      @items = nil
    else
      @items = get_items(item_ids)
      @properties = make_cart(item_ids)
    end
  end

  def get_items(ids)
    item_maker = UltracartService.new
    items = ids.map do |id|
      Item.new(item_maker.get_item(id)) # definitely want to refactor to get raw_items once for both methods and later turn into items
    end
  end

  def make_cart(ids)
    cart = UltracartService.new
    items = ids.map do |id|
      cart.get_item(id)
    end
    Cart.new(cart.add_item(items))
  end

  def remove(id)
    @ids.delete_at(@ids.index(id))
    CartMaker.new(@ids)
  end
  
end
