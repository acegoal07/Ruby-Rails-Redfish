class Api::ServersController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_cabinet, only: %i[ update destroy ]

  def index
    render json: Cabinet.all
  end

  def create
    @cabinet = Cabinet.new(cabinet_params)

    if @cabinet.save
      render json: {
        success: true,
        server_id: @cabinet.id,
        message: "Cabinet created successfully"
      }, status: :created
    else
      render json: {
        success: false,
        errors: @cabinet.errors.full_messages
      }, status: :unprocessable_entity
    end
  end

  def update
    if @cabinet.update(cabinet_params)
      render json: {
        success: true,
        message: "Cabinet updated successfully"
      }, status: :ok
    else
      render json: {
        success: false,
        errors: @cabinet.errors.full_messages
      }, status: :unprocessable_entity
    end
  end

  def destroy
    @cabinet.destroy
    render json: { success: true, message: "Cabinet deleted successfully" }, status: :ok
  end

  def show
    render json: Cabinet.find(params[:id])
  end

  private
  def set_cabinet
    @cabinet = Cabinet.find(params[:id])
  end

  def cabinet_params
    params.expect(cabinet: [
      :name,
      :u_size,
      :notes
    ])
  end
end
