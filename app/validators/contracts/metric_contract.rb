require './app/validators/contracts/application_contract.rb'

class MetricContract < ApplicationContract
  register_macro(:metric_negative) do
    key.failure("Metrics mustn't be negative") if value.negative?
  end

  params(MetricSchema)

  rule(:hot) do
    key.failure("Metrics mustn't be negative") if value.negative?
  end


  # rule(:cold).validate(:metric_negative)
  # rule(:hot).validate(:metric_negative)
end
