# typed: true

# DO NOT EDIT MANUALLY
# This is an autogenerated file for dynamic methods in `RSpec::ExampleGroups::Car`.
# Please instead update this file by running `bin/tapioca dsl RSpec::ExampleGroups::Car`.


class RSpec::ExampleGroups::Car < RSpec::Core::ExampleGroup
  include ::RSpec::ExampleGroups::Car::LetDefinitions

  class << self
    sig { params(args: T.untyped, block: T.proc.bind(RSpec::ExampleGroups::Car).void).returns(T.untyped) }
    def after(*args, &block); end

    sig { params(args: T.untyped, block: T.proc.bind(RSpec::ExampleGroups::Car).void).returns(T.untyped) }
    def before(*args, &block); end

    sig { params(all_args: T.untyped, block: T.proc.bind(RSpec::ExampleGroups::Car).void).returns(T.untyped) }
    def it(*all_args, &block); end

    sig { params(name: T.untyped, block: T.proc.bind(RSpec::ExampleGroups::Car).void).returns(T.untyped) }
    def let(*name, &block); end

    sig { params(all_args: T.untyped, block: T.proc.bind(RSpec::ExampleGroups::Car).void).returns(T.untyped) }
    def specify(*all_args, &block); end
  end
end

module RSpec::ExampleGroups::Car::LetDefinitions
  sig { returns(T.untyped) }
  def claim_value; end
end
