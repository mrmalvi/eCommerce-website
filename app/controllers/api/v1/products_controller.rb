module Api
  module V1
    class ProductsController < ApplicationController

      def index
        query = params[:query]
        min_price = params[:min_price]
        max_price = params[:max_price]
        colors = params[:colors]
        sizes = params[:sizes]

        filters = []

        if min_price.present? && max_price.present?
          filters << {
            range: {
              price: {
                gte: min_price,
                lte: max_price
              }
            }
          }
        end

        if colors.present?
          filters << {
            terms: {
              colors: colors.split(',')
            }
          }
        end

        if sizes.present?
          filters << {
            terms: {
              sizes: sizes.split(',')
            }
          }
        end

        must_clause = if query.present?
          { multi_match: { query: query, fields: ['title^5', 'description'] } }
        else
          { match_all: {} }
        end

        @products = Product.search({
          query: {
            bool: {
              must: must_clause,
              filter: filters
            }
          }
        }).records

        render json: @products
      end
    end
  end
end
