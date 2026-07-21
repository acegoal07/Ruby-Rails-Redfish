class History < ApplicationRecord
  belongs_to :server

  before_save :set_defaults

  def set_defaults
    self.system_name ||= "Unknown"
    self.system_model ||= "Unknown"
    self.system_uuid ||= "Unknown"
    self.memory_total_gib ||= 0
    self.cpu_model ||= "Unknown"
    self.cpu_count ||= 0
    self.core_count ||= 0
    self.logical_core_count ||= 0
    self.bios_version ||= "0.0.0"
    self.slot ||= 0
    self.u_position ||= 0
  end
end
