class String
  include ActionView::Helpers::NumberHelper

  def to_currency
    number_to_currency(self, unit: "")
  end
end
