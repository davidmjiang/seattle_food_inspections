class Violation < ActiveRecord::Base
  belongs_to :restaurant
  belongs_to :inspection

  def v_date
    inspection.date
  end
end
