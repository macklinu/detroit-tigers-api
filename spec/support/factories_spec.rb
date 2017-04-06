# frozen_string_literal: true

RSpec.describe 'Factory Girl' do
  FactoryGirl.factories.map(&:name).each do |factory_name|
    describe "#{factory_name} factory" do
      # Test each factory
      it 'is valid' do
        factory = FactoryGirl.build(factory_name)
        if factory.respond_to?(:valid?)
          # the lamdba syntax only works with rspec 2.14 or newer
          # rubocop:disable Metrics/LineLength
          expect(factory).to be_valid, (-> { factory.errors.full_messages.join('\n') })
          # rubocop:enable Metrics/LineLength
        end
      end

      # Test each trait
      FactoryGirl.factories[factory_name].definition
                 .defined_traits.map(&:name).each do |trait_name|
        context "with trait #{trait_name}" do
          it 'is valid' do
            factory = FactoryGirl.build(factory_name, trait_name)
            if factory.respond_to?(:valid?)
              # rubocop:disable Metrics/LineLength
              expect(factory).to be_valid, (-> { factory.errors.full_messages.join('\n') })
              # rubocop:enable Metrics/LineLength
            end
          end
        end
      end
    end
  end
end
