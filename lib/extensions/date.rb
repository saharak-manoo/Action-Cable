class Date
  def updated_at_formatted
    self.strftime('%d/%m/%Y เมื่อเวลา %H:%M')
  rescue
    ''
  end

  def datetime_formatted
    self.strftime("%d/%m/%Y") rescue ""
  end
end
