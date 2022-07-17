class Api::V1::JansousController < ApplicationController
  before_action :set_jansou, only: %i[show update destroy]

  # GET /jansous
  # GET /jansous.json
  def index
    @jansous = Jansou.all
  end

  # GET /jansous/1
  # GET /jansous/1.json
  def show; end

  # POST /jansous
  # POST /jansous.json
  def create
    @jansou = Jansou.new(jansou_params)

    if @jansou.save
      render :show, status: :created, location: api_v1_jansou_url(@jansou)
    else
      render json: @jansou.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /jansous/1
  # PATCH/PUT /jansous/1.json
  def update
    if @jansou.update(jansou_params)
      render :show, status: :ok, location: api_v1_jansou_url(@jansou)
    else
      render json: @jansou.errors, status: :unprocessable_entity
    end
  end

  # DELETE /jansous/1
  # DELETE /jansous/1.json
  def destroy
    @jansou.destroy
    head :no_content
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_jansou
    @jansou = Jansou.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def jansou_params
    params.permit(:name, :google_map_url, :address, :note)
  end
end
