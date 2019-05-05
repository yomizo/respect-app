module V1
  class MetoosController < ApplicationController
    before_action :set_metoo, only: [:destroy]
    before_action :authenticate, except: [:index, :show]
    
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

    def destroy
      @metoo.destroy
      head 204
    end

    private

    def set_metoo
      @metoo = Metoo.find(id: params[:id])
      authorize @metoo
    end
    # permition
    def metoo_params
      params.require(:metoo).permit(:user_id, :post_id)
    end
  end
end