module Admin
  class CategoriesController < BaseController
    before_action :set_category, only: [:show, :destroy, :edit, :update]

    def index
      @categories = Category.all
    end

    def show
      subcategory_ids = @category.subcategories.ids
      category_ids = [@category.id] + subcategory_ids

      search_field = params[:search].present? ? params[:search] : '*'
      category_id = params[:category].present? ? params[:category].to_i : nil
      min_price = params[:min_price].present? ? params[:min_price].to_f : nil
      max_price = params[:max_price].present? ? params[:max_price].to_f : nil
      colors = params[:colors].present? ? params[:colors].split(',') : nil
      sizes = params[:sizes].present? ? params[:sizes].split(',') : nil

      search_conditions = { category_id: category_ids }
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
      respond_to do |format|
        format.html { render :show }
        format.turbo_stream do
          render turbo_stream: turbo_stream.update('category_products',
                                                   partial: 'admin/categories/products',
                                                   locals: { products: @products })
        end
      end
    end

    def new
      @category = Category.new
    end

    def create
      @category = Category.new(category_params)
      if @category.save
        redirect_to admin_categories_path, notice: "category has been successfully created."
      else
        flash[:error] = @category.errors.full_messages.to_sentence
        render :new
      end
    end

    def edit
    end

    def update
    end

    def destroy
      if @category.destroy
        redirect_to admin_categories_path, notice: 'category has been successfully destroyed.'
      else
        flash[:error] = @category.errors.full_messages.to_sentence
        redirect_to admin_categories_path
      end
    end

    private

      def set_category
        @category = Category.find(params[:id])
      end

      def category_params
        params.require(:category).permit(:name, :parent_id)
      end
  end
end
