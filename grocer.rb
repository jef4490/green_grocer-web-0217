require 'pry'
def consolidate_cart(cart)
  cart_hash = {}
  cart.each do |item|
    item.each do |name, details|
    if cart_hash[name] == nil
      cart_hash[name] = details
      cart_hash[name][:count] = 1
    else
      counter = cart_hash[name][:count]
      #binding.pry
      cart_hash[name][:count] = (counter + 1)
    end
  end
end
#binding.pry
  cart_hash
end

def apply_coupons(cart, coupons)
  coupon_cart = cart
  coupons.each do |coupon|
    if coupon_cart[coupon[:item]] != nil && coupon_cart[coupon[:item]][:count] >= coupon[:num]
      counter = coupon_cart[coupon[:item]][:count]
      if coupon_cart["#{coupon[:item]} W/COUPON"] == nil
        coupon_cart["#{coupon[:item]} W/COUPON"] = {price: coupon[:cost], clearance: coupon_cart[coupon[:item]][:clearance], count: 1}
        coupon_cart[coupon[:item]][:count] = counter - coupon[:num]
      else
        coupon_counter = coupon_cart["#{coupon[:item]} W/COUPON"][:count]
        coupon_cart["#{coupon[:item]} W/COUPON"][:count] = coupon_counter + 1
        coupon_cart[coupon[:item]][:count] = counter - coupon[:num]
      end
    end
  end
  #binding.pry
  coupon_cart
end

def apply_clearance(cart)
  applied_cart = cart
  cart.each do |item, data|
    if data[:clearance] == true
      #binding.pry
      data[:price] = (data[:price] * 0.8).round(2)
    end
  end
  applied_cart
end

def checkout(cart, coupons)
  cons_cart = consolidate_cart(cart)
  coupon_cart = apply_coupons(cons_cart, coupons)
  total_cart = apply_clearance(coupon_cart)
  cost = 0.00
  total_cart.each { |item, data|
  cost = cost + (data[:price] * data[:count])  }
  if cost > 100.00
    cost = cost * 0.90
  end
  cost
end
