class CreateComponent 
    class << self
      def call(survey, params, error_tracker: ErrorTracker.new)
        begin
          result = process(survey, params)
        rescue => e
          error_tracker.add_error(e.message)
        end
        OperationResponseBuilder.call(result, error_tracker)
      end
  
      private
  
      def process(survey, params)
        component = survey.components.new(params)
        unless component.save
          raise_error(component.errors.full_messages.join(", "))
        end
        component
      end
  
      def raise_error(errors)
        raise errors
      end
    end
  end