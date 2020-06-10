class Members::ProductsController < ApplicationController
	def index
		@tax = 1.1
		@products = Product.joins(:product_genre).where(product_genres: {is_enabled: true}).page(params[:page]).reverse_order
		@pn = Product.joins(:product_genre).where(product_genres: {is_enabled: true}).count
	end

	def show
		@cart_item = CartItem.new
		@product = Product.find(params[:id])
		@tax = 1.1
	end

	def genre_index
		@genre = ProductGenre.find(params[:id])
		@products = @genre.products.joins(:product_genre).where(product_genres: {is_enabled: true}).page(params[:page]).reverse_order
		@pn = @genre.products.joins(:product_genre).where(product_genres: {is_enabled: true}).count
		@tax = 1.1
	end
end
