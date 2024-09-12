module Api
  module V1
    class ProductsController < ApplicationController

      def index
        search_field = params[:search].present? ? params[:search] : '*'
        category_id = params[:category].present? ? params[:category].to_i : nil
        min_price = params[:min_price].present? ? params[:min_price].to_f : nil
        max_price = params[:max_price].present? ? params[:max_price].to_f : nil
        colors = params[:colors].present? ? params[:colors].split(',') : nil
        sizes = params[:sizes].present? ? params[:sizes].split(',') : nil

        search_conditions = {}
        search_conditions[:category_id] = category_id if category_id
        search_conditions[:price] = { gte: min_price, lte: max_price } if min_price || max_price
        search_conditions[:colors] = colors if colors
        search_conditions[:sizes] = sizes if sizes

        if params[:search].present?
          search_conditions[:or] = [
            { title: { wildcard: "*#{params[:search]}*" } },
            { description: { wildcard: "*#{params[:search]}*" } }
          ]
        end

        @products = Product.search('*', where: search_conditions)
        render json: @products, status: 200
      end
    end
  end
end
