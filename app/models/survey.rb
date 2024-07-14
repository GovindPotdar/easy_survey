class Survey < ApplicationRecord
    has_many :components

    validates :name, presence: true
end
