module ApplicationHelper

  def to_local_date(utc_date)
    utc_date.in_time_zone.strftime("%d/%m/%Y %H:%M")
  end
end
