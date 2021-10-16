# frozen_string_literal: true
namespace :setup do
  desc 'Load data from files'

  task load_data: :environment do
    create_from_file =  ->(model, file_name) do
      model_attributes = JSON.parse(File.read(file_name))['RECORDS']
      model_instances = model_attributes.map do |attributes|
        model.new(attributes) do |m|
          m.id = attributes['id'].to_i
        end
      end

      model_instances.each do |instance|
        if instance.valid?
          instance.save!
        else
          p "#{model.to_s} #{instance.id} unable to import: #{instance.errors.full_messages}"
        end
      end
    end

    create_from_file.(Merchant, 'merchants.json')
    create_from_file.(Shopper, 'shoppers.json')
    create_from_file.(Order, 'orders.json')

    p "total Merchants imported: #{Merchant.count}"
    p "total Shoppers imported: #{Shopper.count}"
    p "total Orders imported: #{Order.count}"
  end
end
