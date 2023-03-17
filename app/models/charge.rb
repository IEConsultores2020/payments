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
class Charge < ApplicationRecord
  enum statust: [:created, :pending, :paid, :rejected, :error]
  enum payment_method: [:unknown, :credit_card, :debit_card, :pse, :cash, :referenced]

  before_create :generate_uid

private
  def generate_uid
    begin
      self.uid = SecureRandom.hex(5)
    end while self.class.exists?(uid: self.uid)
  end
end
