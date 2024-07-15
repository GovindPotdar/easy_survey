class Survey < ApplicationRecord
    acts_as_paranoid
    
    has_many :components, dependent: :destroy
    validates :name, presence: true
end
