class Match < ApplicationRecord
  validates :host, :guest, :date, presence: true
  validates :score, length: { minimum: 3 }, format: { with: /([0-9]+)\:([0-9]+)/ }
end
