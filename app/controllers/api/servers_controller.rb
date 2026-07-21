class Api::ServersController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_server, only: %i[ update destroy ]

  def index
    render json: Server.all
  end

  def create
    uploaded_file = params[:server][:file]
    if uploaded_file.nil?
      return render json: { success: false, error: "No file provided" }, status: :bad_request
    end

    json_data = JSON.parse(uploaded_file.read)

    if json_data["UUID"].nil? || json_data["UUID"].empty?
      return render json: { success: false, error: "No UUID found in the JSON file" }, status: :bad_request
    end

    existing_server = Server.where(system_uuid: json_data["UUID"]).first

    if existing_server && !existing_server&.id&.nil?
      return render json: { success: false, error: "Server already exists" }, status: :conflict
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
      render json: {
        success: true,
        server_id: @server.id,
        message: "Server created successfully"
      }, status: :created
    else
      render json: {
        success: false,
        errors: @server.errors.full_messages
      }, status: :unprocessable_entity
    end
  end

  def update
    if params[:id].nil?
      return render json: { success: false, error: "No server id provided" }, status: :bad_request
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
      render json: {
        success: true,
        message: "Server updated successfully"
      }, status: :ok
    else
      render json: {
        success: false,
        errors: @server.errors.full_messages
      }, status: :unprocessable_entity
    end
  end

  def destroy
    @server.destroy
    render json: { success: true, message: "Server deleted successfully" }, status: :ok
  end

  def show
    render json: Server.find(params[:id])
  end

  private
  def set_server
    @server = Server.find(params[:id])
  end
end
