class CategoriesController < ApplicationController
  def show
    @category = Category.find(params[:id])
    @products = @category.products

    @products = @products.where('price >= ?', params[:min_price]) if params[:min_price].present?
    @products = @products.where('price <= ?', params[:max_price]) if params[:max_price].present?
    @products = @products.where(color: params[:color]) if params[:color].present?
    @products = @products.where('sizes @> ARRAY[?]::varchar[]', params[:size]) if params[:size].present?
  end
end
