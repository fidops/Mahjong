class Api::V1::AdministratorsController < ApplicationController
  before_action :set_administrator, only: %i[show update destroy]

  # GET /administrators
  # GET /administrators.json
  def index
    @administrators = Administrator.all
  end

  # GET /administrators/1
  # GET /administrators/1.json
  def show; end

  # POST /administrators
  # POST /administrators.json
  def create
    @administrator = Administrator.new(administrator_params)

    if @administrator.save
      render :show, status: :created, location: api_v1_administrator_url(@administrator)
    else
      render json: @administrator.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /administrators/1
  # PATCH/PUT /administrators/1.json
  def update
    if @administrator.update(administrator_params)
      render :show, status: :ok, location: api_v1_administrator_url(@administrator)
    else
      render json: @administrator.errors, status: :unprocessable_entity
    end
  end

  # DELETE /administrators/1
  # DELETE /administrators/1.json
  def destroy
    @administrator.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_administrator
    @administrator = Administrator.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def administrator_params
    params.permit(:userid, :password, :password_confirmation)
  end
end
