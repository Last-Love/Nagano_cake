class Members::ShippingAddressesController < ApplicationController
	before_action :authenticate_member!
	def index
		@shipping_address = ShippingAddress.new
		@member = current_member
		@shipping_addresses = @member.shipping_addresses
	end

	def create
		@shipping_address = ShippingAddress.new(shipping_address_params)
		@shipping_address.member_id = current_member.id
		if @shipping_address.save
			redirect_to members_shipping_addresses_path
		else
			@shipping_addresses = ShippingAddress.all
			render "index"
		end
	end

	def edit
		@shipping_address = ShippingAddress.find(params[:id])
	end

	def update
		@shipping_address = ShippingAddress.find(params[:id])
		if @shipping_address.update(shipping_address_params)
			redirect_to members_shipping_addresses_path
		else
			render "edit"
		end
	end

	def destroy
		@shipping_address = ShippingAddress.find(params[:id])
		@shipping_address.destroy
		redirect_to members_shipping_addresses_path
	end

	private
	def shipping_address_params
		params.require(:shipping_address).permit(:postcode, :address, :addressee)
	end
end
