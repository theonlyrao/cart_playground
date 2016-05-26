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

  def raw_items(ids)
    cart = UltracartService.new
    ids.map do |id|
      cart.get_item(id)
    end
  end

  
  def get_items(ids)
    items = raw_items(ids)
    items.map do |item|
      Item.new(item)
    end
  end

  def make_cart(ids)
    items = raw_items(ids)
    Cart.new(UltracartService.new.add_item(items))
  end

  def remove(id)
    @ids.delete_at(@ids.index(id))
    CartMaker.new(@ids)
  end
  
end
