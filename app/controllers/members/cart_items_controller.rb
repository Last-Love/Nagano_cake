class Members::CartItemsController < ApplicationController
	before_action :authenticate_member!
	def show
		@carts = current_member.cart_items
		@tax = 1.1
	end

	def create
		@cart = CartItem.new(cart_item_params)
		@cart.member_id = current_member.id
		@cart.save
		redirect_to members_cart_item_path(current_member)
	end

	def update
		@cart = CartItem.find(params[:id])
		@cart.update(cart_item_params)
		redirect_to members_cart_item_path
	end

	def destroy
		@cart = CartItem.find(params[:id])
		@cart.destroy
		redirect_to members_cart_item_path
	end

	def destroy_all
		@carts = current_member.cart_items
		@carts.destroy_all
		redirect_back(fallback_location: root_path)
	end

	private
	def cart_item_params
		params.require(:cart_item).permit(:member_id, :product_id, :number)
	end
end
