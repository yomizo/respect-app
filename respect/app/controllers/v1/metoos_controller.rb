module V1
  class MetoosController < ApplicationController
    before_action :set_metoo, only: [:show, :update, :destroy]
    
    def index
      metoos = Metoo.all
      render json: metoos, adapter: :json
    end

    def show
      render json: @metoo, adapter: :json
    end

    def create
      metoo = Metoo.new(metoo_params)
      if metoo.save
        render json: metoo, adapter: :json, status: 201
      else
        render json: { error: metoo.errors }, status: 422
      end
    end

    def update
      if @metoo.update(metoo_params)
        render json: @metoo, adapter: :json, status: 200
      else
        render json: { error: @metoo.errors }, status: 422
      end
    end

    def destroy
      @metoo.destroy
      head 204
    end

    private

    def set_metoo
      @metoo = Metoo.find(params[:id])
    end
    # permition
    def metoo_params
      params.require(:metoo).permit(:user_id, :post_id)
    end
  end
end