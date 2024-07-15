class DeleteComponent
  class << self
    def call(survey, component_id, error_tracker: ErrorTracker.new)
      begin
        result = process(survey, component_id)
      rescue => e
        error_tracker.add_error(e.message)
      end
      OperationResponseBuilder.call(result, error_tracker)
    end

    private

    def process(survey, component_id)
      component = survey.components.with_deleted.find_by_id(component_id)
      raise_error("Component not found for survey: #{survey.name}") if component.blank?
      return if component.deleted?
      unless component.destroy
        raise_error("Failed to delete component")
      end
    end

    def raise_error(errors)
      raise errors
    end
  end
end
