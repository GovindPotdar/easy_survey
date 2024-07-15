class UpdateComponent 
    class << self
      def call(survey, component_id, params, error_tracker: ErrorTracker.new)
        begin
          result = process(survey, component_id, params)
        rescue => e
          error_tracker.add_error(e.message)
        end
        OperationResponseBuilder.call(result, error_tracker)
      end
  
      private
  
      def process(survey, component_id, params)
        component = survey.components.with_deleted.find_by_id(component_id)
        raise_error("Component not found") if component.blank?
        unless component.update(params.merge!({deleted_at: nil}))
          raise_error(component.errors.full_messages.join(", "))
        end
        component
      end
  
      def raise_error(errors)
        raise errors
      end
    end
  end