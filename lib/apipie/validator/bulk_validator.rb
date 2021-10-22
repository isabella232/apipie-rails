module Apipie
  module Validator
    class BulkValidator < BaseValidator
      include Apipie::DSL::Base
      include Apipie::DSL::Param

      VALIDATOR_TYPE = :bulk

      def initialize(param_description, items_argument, options = {}, block)
        super(param_description)

        items_param_description = Apipie::ParamDescription.new(
          param_description.method_description,
          param_description.name,
          items_argument,
          nil,
          &block
        )
        @validator = items_param_description.validator
        @type = :bulk
      end

      def params_ordered
        @validator.params_ordered
      end

      def validate(_value)
        # always return true for the apipie validator, we use our own validator to do the real param validation
        true
      end

      def self.build(param_description, argument, options, block)
        return unless argument == VALIDATOR_TYPE && block.is_a?(Proc) && block.arity <= 0

        new(param_description, Hash, options, block)
      end

      def expected_type
        'bulk'
      end

      def description
        'bulk must be an Array of Hash'
      end

      def items_validator
        @validator
      end
    end
  end
end