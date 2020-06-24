require 'dry/validation'

MetricSchema = Dry::Schema.Params do
  required(:cold).filled(:integer)
  required(:hot).filled(:integer)
end
