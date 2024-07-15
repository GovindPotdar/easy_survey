class BulkUpdateComponents 
  class << self
    def call(survey, components, error_tracker: ErrorTracker.new)
      begin
        result = process(survey, components)
      rescue => e
        error_tracker.add_error(e.message)
      end
      OperationResponseBuilder.call(result, error_tracker)
    end

    private

    def process(survey, components)
      ActiveRecord::Base.transaction do 
        component_ids = survey.components.with_deleted.ids
        components.each do |component|
          response = if component_ids.include?(component[:id]) 
            component_ids.delete(component[:id]) # After this only those ids will remain which we want to remove
            UpdateComponent.call(survey, component[:id], prepare_params(component))
          else
            CreateComponent.call(survey, prepare_params(component))
          end
          raise_error(response[:errors].join(", ")) if response[:status] == :failure
        end
        component_ids.each { |component_id| delete_component(survey, component_id) }
      end 
    end

    def prepare_params(component)
      {
        text: component[:text],
        x_axis: component[:x_axis],
        y_axis: component[:y_axis],
        field: component[:field]
      }
    end

    def delete_component(survey, component_id)
      response = DeleteComponent.call(survey, component_id)
      raise_error(response[:errors].join(", ")) if response[:status] == :failure
    end

    def raise_error(errors)
      raise errors
    end
  end
end