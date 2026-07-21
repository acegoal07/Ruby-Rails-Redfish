require "json"

class ServersController < ApplicationController
  before_action :set_server, only: %i[ edit show update destroy ]

  def index
    @servers = Server.all
  end

  def show
    entry = params[:entry].to_i || 0

    if params[:entry].nil?
      redirect_to server_path(@server, entry: 0)
    end

    history = @server.history.order(created_at: :desc)

    if entry == 0
      @server_data = Server.find(params[:id])
      @history_size = history.size
      if @server.cabinet_id.nil?
        @cabinet = nil
      else
        @cabinet = Cabinet.find(@server.cabinet_id)
      end
      @json = JSON.pretty_generate(@server_data.json)
    else
      @history_size = history.size
      if @history_size.zero? || entry < 0
        redirect_to server_path(@server, entry: 0)
      elsif entry > @history_size
        redirect_to server_path(@server, entry: @history_size)
      else
      got_history = history[entry.to_i - 1]
      @json = JSON.pretty_generate(got_history.json)
      @server_data = got_history
      @cabinet = Cabinet.find(@server.cabinet_id)
      end
    end
  end

  def new
    @server = Server.new
    @cabinets = Cabinet.all
  end

  def create
    uploaded_file = params[:server][:file]
    if uploaded_file.nil?
      return
    end

    json_data = JSON.parse(uploaded_file.read)

    if json_data["UUID"].nil? || json_data["UUID"].empty?
      return
    end

    existing_server = Server.where(system_uuid: json_data["UUID"]).first

    if existing_server && !existing_server&.id&.nil?
      redirect_to server_path(existing_server.id)
      return
    end

    memory_info = json_data["MemorySummary"] || {}
    processor_info = json_data["ProcessorSummary"] || {}

    @server = Server.new(
      system_model: json_data["Model"],
      system_name: json_data["Name"],
      system_uuid: json_data["UUID"],
      memory_total_gib: memory_info["TotalSystemMemoryGiB"],
      cpu_model: processor_info["Model"],
      cpu_count: processor_info["Count"],
      core_count: processor_info["CoreCount"],
      logical_core_count: processor_info["LogicalProcessorCount"],
      bios_version: json_data["BiosVersion"],
      cabinet_id: params[:server][:cabinet_id],
      slot:  params[:server][:slot],
      u_position:  params[:server][:u_position],
      notes: params[:server][:notes],
      json: json_data
    )

    if @server.save
      redirect_to @server
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @cabinets = Cabinet.all
  end

  def update
    if params[:id].nil?
      return
    end

    uploaded_file = params[:server][:file]

    json_data = nil
    if uploaded_file.nil?
      json_data = @server.json
    else
      json_data = JSON.parse(uploaded_file.read)
    end

    tmp = @server.attributes

    tmp.delete("id")

    @server.history.create(tmp).save

    memory_info = json_data["MemorySummary"] || {}
    processor_info = json_data["ProcessorSummary"] || {}

    if @server.update({
      system_model: json_data["Model"],
      system_name: json_data["Name"],
      memory_total_gib: memory_info["TotalSystemMemoryGiB"],
      cpu_model: processor_info["Model"],
      cpu_count: processor_info["Count"],
      core_count: processor_info["CoreCount"],
      logical_core_count: processor_info["LogicalProcessorCount"],
      bios_version: json_data["BiosVersion"],
      cabinet_id: params[:server][:cabinet_id],
      slot:  params[:server][:slot],
      u_position:  params[:server][:u_position],
      json: json_data,
      notes: params[:server][:notes],
      updated_at: Time.now
    })
      redirect_to @server
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @server.destroy
    redirect_to servers_path
  end

  private
  def set_server
    @server = Server.find(params[:id])
  end
end

class Api::ServersController < ApplicationController
  def index
    render json: Server.all
  end
end
