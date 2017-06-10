RSpec::Matchers.define :receive_service_call do
  match do |service_class|
    @service_double = double service_class.name

    if @args
      expect(service_class).to receive(:new).with(*@args).and_return @service_double
    else
      expect(service_class).to receive(:new).and_return @service_double
    end

    if @return_value
      expect(@service_double).to receive(:call).and_return @return_value
    elsif @raise_args
      expect(@service_double).to receive(:call).and_raise *@raise_args
    else
      expect(@service_double).to receive(:call)
    end
  end

  chain :with do |*args|
    @args = args
  end

  chain :and_return do |return_value|
    @return_value = return_value
  end

  chain :and_raise do |*args|
    @raise_args = args
  end
end
