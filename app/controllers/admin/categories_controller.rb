module Admin
  class CategoriesController < BaseController
    before_action :set_category, only: [:show, :destroy, :edit, :update]

    def index
      @categories = Category.all
    end

    def show
      subcategory_ids = @category.subcategories.pluck(:id)
      category_ids = [@category.id] + subcategory_ids
      @products = Product.where(category_id: category_ids)
      @products = @products.where('price >= ?', params[:min_price].to_f) if params[:min_price].present?
      @products = @products.where('price <= ?', params[:max_price].to_f) if params[:max_price].present?
      if params[:colors].present?
        colors = params[:colors].split(',').map { |color| "%#{color.strip}%" }
        @products = @products.where(colors.map { 'colors LIKE ?' }.join(' OR '), *colors)
      end

      if params[:sizes].present?
        sizes = params[:sizes].split(',').map { |size| "%#{size.strip}%" }
        @products = @products.where(sizes.map { 'sizes LIKE ?' }.join(' OR '), *sizes)
      end
      @products
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
