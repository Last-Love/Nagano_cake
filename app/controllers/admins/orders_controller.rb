class Admins::OrdersController < ApplicationController
	before_action :authenticate_admin!
	def index
		@version = params[:version].to_s

		if @version == 'today'
			@orders = Order.where(created_at: Time.zone.now.all_day).page(params[:page]).per(10)
		elsif @version == 'member'
			@member = Member.find(params[:id])
			@orders = @member.orders.page(params[:page]).per(10)
		else
			@orders = Order.all.page(params[:page]).per(10)
		end
	end

	def show
		@order = Order.find(params[:id])
		@products = @order.order_products
	end

	def update
		@order = Order.find(params[:id])
		@order.update(order_params)

		if @order.order_status == 2
			@order.order_products.each do |op|
				op.update(production_status: 2)
			end
		end
		redirect_back(fallback_location: root_path)
	end

	private
	def order_params
		params.require(:order).permit(:order_status)
	end

	def order_product_params
		params.require(:order_product).permit(:id, :production_status)
	end
end
