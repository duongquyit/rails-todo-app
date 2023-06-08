class Task < ApplicationRecord
  def self.filter_by(field, value)
    where(field + " LIKE ?", value)
  end
end
