class PayuController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:confirmation]

  def result
    @charge = Charge.where(uid: params[:referenceCode]).take
    if @charge.nil?
      return "No se encontró la información del pago"
    end

    if params[:sign] != signature(@charge, params[:transactionState])
      @error = "La firma no es valida"
    end
  end

  def confirmation
    @charge = Charge.where(uid: params[:reference_sale]).take

    if charge.nil?
      head :unprocessable_entity
      return
    end

    if params[:sign] == signature(@charge, params[:state_pol])
      head :ok                   # Code 200
    else
      head :unprocessable_entity # Code 422
      return
    end
  end

private
def signature(charge,state)
  #msg = "ApiKey~merchantId~referenceCode~amount~currency"
  msg = "#{ENV["PAYU_API_KEY"]}~#{ENV["PAYU_MERCHANT_ID"]}~#{charge.uid}~#{charge.amount}~COP~#{params[state]}"
  Digest::MD5.hexdigest(msg)
end

end

