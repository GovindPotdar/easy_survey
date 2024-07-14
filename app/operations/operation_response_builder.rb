class OperationResponseBuilder
    class << self
        def call(result, error_tracker)
            process(result, error_tracker)
        end

        private

        def process(result, error_tracker)
            {
                result: result,
                status: error_tracker.any? ? :failure : :success,
                errors: error_tracker.errors
            }
        end
    end
end
