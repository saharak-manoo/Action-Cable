class DateTime
  def updated_at_formatted
    self.strftime('%d/%m/%Y เมื่อเวลา %H:%M')
  rescue
    ''
  end

  def datetime_formatted
    self.strftime('%d/%m/%Y')
  rescue
    ''
  end

  def utc_to_local
    self.in_time_zone('Asia/Bangkok')
  end

  def self.current_year
    self.now.strftime('%Y').to_i
  end
end
