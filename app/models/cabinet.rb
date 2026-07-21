class Cabinet < ApplicationRecord
  has_many :server, dependent: :destroy

  before_save :set_defaults

  def set_defaults
    self.name ||= "Unknown"
    self.u_size ||= 0
  end
end
