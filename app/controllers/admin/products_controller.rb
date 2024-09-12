module Admin
  class ProductsController < BaseController
    before_action :set_product, only: [:show, :destroy, :edit, :update]

    def index
      @products = Product.all
    end

    def show
    end

    def new
      @product = Product.new
    end

    def create
      @product = Product.new(product_params)
      if @product.save
        redirect_to admin_products_path, notice: "Product has been successfully created."
      else
        flash[:error] = @product.errors.full_messages.to_sentence
        render :new
      end
    end

    def edit
    end

    def update
      if @product.update(product_params)
        redirect_to admin_products_path, notice: 'Product has been successfully destroyed.'
      else
        flash[:error] = @product.errors.full_messages.to_sentence
        render :edit
      end
    end

    def destroy
      if @product.destroy
        redirect_to admin_products_path, notice: 'Product has been successfully destroyed.'
      else
        flash[:error] = @product.errors.full_messages.to_sentence
        redirect_to admin_products_path
      end
    end

    private

      def set_product
        @product = Product.find(params[:id])
      end

      def product_params
        sanitize_params
      end

      def sanitize_params
        set_params = params.require(:product).permit(:title, :description, :price, :category_id, :colors, :sizes, images: [])
        set_params[:colors] = set_params[:colors]&.split(",")&.map(&:strip).presence || []
        set_params[:sizes] = set_params[:sizes]&.split(",")&.map(&:strip).presence || []
        set_params
      end
  end
end
