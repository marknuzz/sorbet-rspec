# frozen_string_literal: true
# typed: strict

# This test doesn't actually do anything useful. It only
# serves to test whether there are typechecking errors.

require "sorbet-runtime"
require "rspec"
require "rspec/sorbet"

RSpec::Sorbet.allow_doubles!

class Car
  extend T::Sig

  sig { returns(Integer) }
  attr_reader :beep_count

  sig { void }

  def initialize
    @beep_count = T.let(0, Integer)
  end

  sig { void }

  def beep
    @beep_count += 1
  end

  sig { params(insurer: Insurer, value: Integer).void }

  def report_damage(insurer, value)
    insurer.submit_claim(self, value)
  end
end

class Insurer
  extend T::Sig

  sig { returns(Integer) }
  attr_reader :total_claim_value

  sig { void }

  def initialize
    @total_claim_value = T.let(0, Integer)
  end

  sig { params(car: Car, value: Integer).void }

  def submit_claim(car, value)
    @total_claim_value += value
  end
end

# Workaround for https://github.com/sorbet/sorbet/issues/8143
if false
  T::Sig::WithoutRuntime.sig { params(block: T.proc.bind(T::Private::Methods::DeclBuilder).void).void }

  def sig(&block); end
end

RSpec.describe Car do
  T.bind(self, T.class_of(RSpec::ExampleGroups::Car))
  extend T::Sig

  let(:claim_value) { 100 }

  sig { returns(Car) }

  def create_car
    Car.new
  end

  specify "#expect and #eq work" do
    car = Car.new
    car.beep
    expect(car.beep_count).to eq(1)
  end

  specify "#let works" do
    car = Car.new
    insurer = Insurer.new
    car.report_damage(insurer, claim_value)
    expect(insurer.total_claim_value).to eq(claim_value)
  end

  specify "#instance_double works" do
    car = Car.new
    insurer = instance_double(Insurer)
    expect(insurer).to receive(:submit_claim).with(car, claim_value)
    car.report_damage(insurer, claim_value)
  end

  specify "locally-defined methods work" do
    expect(create_car).to be_a(Car)
  end

  context "sub-context" do
    T.bind(self, T.class_of(RSpec::ExampleGroups::Car::SubContext))

    let(:local_number) { 200 }

    sig { returns(Integer) }

    def local_number2
      202
    end

    it "can call parent lets and methods" do
      expect(claim_value).to eq(100)
      expect(create_car).to be_a(Car)
    end

    it "can call local lets and methods" do
      expect(local_number).to eq(200)
      expect(local_number2).to eq(202)
    end
  end
end
