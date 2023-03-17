# == Schema Information
#
# Table name: charges
#
#  id             :bigint           not null, primary key
#  uid            :string
#  status         :integer
#  payment_method :integer
#  amount         :decimal(, )
#  error_message  :text
#  response       :jsonb
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
require "test_helper"

class ChargeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
