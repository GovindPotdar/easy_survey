class CreateSurvey 
  class << self
    def call(params, error_tracker: ErrorTracker.new)
      begin
        result = process(params)
      rescue => e
        error_tracker.add_error(e.message)
      end
      OperationResponseBuilder.call(result, error_tracker)
    end

    private

    def process(params)
      survey = Survey.new(params)
      unless survey.save
        raise_error(survey.errors.full_messages.join(", "))
      end
      survey
    end

    def raise_error(errors)
      raise errors
    end
  end
end