class Api::V1::MahjongJansousController < ApplicationController
  before_action :set_mahjong_jansou, only: %i[show update destroy]

  # GET /mahjong_jansous
  # GET /mahjong_jansous.json
  def index
    @mahjong_jansous = MahjongJansou.all
  end

  # GET /mahjong_jansous/1
  # GET /mahjong_jansous/1.json
  def show; end

  # POST /mahjong_jansous
  # POST /mahjong_jansous.json
  def create
    @mahjong_jansou = MahjongJansou.new(mahjong_jansou_params)

    if @mahjong_jansou.save
      render :show, status: :created, location: @mahjong_jansou
    else
      render json: @mahjong_jansou.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /mahjong_jansous/1
  # PATCH/PUT /mahjong_jansous/1.json
  def update
    if @mahjong_jansou.update(mahjong_jansou_params)
      render :show, status: :ok, location: @mahjong_jansou
    else
      render json: @mahjong_jansou.errors, status: :unprocessable_entity
    end
  end

  # DELETE /mahjong_jansous/1
  # DELETE /mahjong_jansous/1.json
  def destroy
    @mahjong_jansou.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_mahjong_jansou
    @mahjong_jansou = MahjongJansou.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def mahjong_jansou_params
    params.require(:mahjong_jansou).permit(:name, :google_map_url, :address, :note)
  end
end
