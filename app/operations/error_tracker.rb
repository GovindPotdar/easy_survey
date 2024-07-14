class ErrorTracker 
    attr_accessor :errors
    
    def initialize
        @errors = []
    end

    def add_error(err)
        @errors.push(*err)
    end

    def any?
        @errors.any?
    end
end