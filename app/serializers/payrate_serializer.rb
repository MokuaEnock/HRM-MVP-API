class PayrateSerializer < ActiveModel::Serializer
  attributes :id
  has_one :employer
end
