class CabinetsController < ApplicationController
  before_action :set_cabinet, only: %i[ show edit destroy update ]

  def index
    @cabinets = Cabinet.all
  end

  def show
  end

  def new
    @cabinet = Cabinet.new
  end

  def create
    @cabinet = Cabinet.new(cabinet_params)

    if @cabinet.save
      redirect_to @cabinet
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @cabinet.update(cabinet_params)
      redirect_to @cabinet
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @cabinet.destroy
    redirect_to cabinets_path
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
