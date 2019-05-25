class ScrapResult < ApplicationRecord
  validates :pid, presence: true, uniqueness: true
end
