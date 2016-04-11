class Note < ActiveRecord::Base
    belongs_to :user
    require 'securerandom'
    before_create :randomize_id
    
    private
        def randomize_id
            self.id = loop do
                random_id = SecureRandom.random_number(10_000_000)
            break random_id unless random_id < 1_000_000 or User.where(id: random_id).exists?
        end
        end  
end
