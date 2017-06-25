class Blog < ActiveRecord::Base
    validates :title, presence: true
    belongs_to :user
<<<<<<< HEAD
end
=======
end
>>>>>>> 86c0d6a2f261c85091f30297c2b2b23311003ea3
