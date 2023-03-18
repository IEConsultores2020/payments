class ChargesController < ApplicationController
  before_action :set_charge, only: %i[ show edit update destroy ]

  # GET /charges or /charges.json
  def index
    @charges = Charge.all
  end

  # GET /charges/1 or /charges/1.json
  def show
    @signature = signature(@charge)
  end

  def payu
    @signature = signature(@charge)
  end


  # GET /charges/new
  def new
    @charge = Charge.new
  end

  # GET /charges/1/edit
  def edit
  end

  def get_signature(charge)
    @signature = signature(charge)
  end
  helper_method :get_signature

  # POST /charges or /charges.json
  def create
    @charge = Charge.new(charge_params)
    respond_to do |format|
      if @charge.save
        @signature = signature(@charge)
        puts ">>>>>>>>>>>>>>>>>>>>>>> After render payu. iud #{@charge.uid} signature #{@signature}"
        #render :payu
        # format.html { redirect_to charge_url(@charge), notice: "Charge was successfully created." }
        # format.json { render :show, status: :created, location: @charge }
      else
        render :new
        # format.html { render :new, status: :unprocessable_entity }
        # format.json { render json: @charge.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /charges/1 or /charges/1.json
  def update
    respond_to do |format|
      if @charge.update(charge_params)
        format.html { redirect_to charge_url(@charge), notice: "Charge was successfully updated." }
        format.json { render :show, status: :ok, location: @charge }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @charge.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /charges/1 or /charges/1.json
  def destroy
    @charge.destroy

    respond_to do |format|
      format.html { redirect_to charges_url, notice: "Charge was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_charge
      @charge = Charge.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def charge_params
      params.require(:charge).permit(:amount)
      #:uid, :status, :payment_method, :error_message, :response
    end


    def signature(charge)
      #msg = "ApiKey~merchantId~referenceCode~amount~currency"
      msg = "#{ENV["PAYU_API_KEY"]}~#{ENV["PAYU_MERCHANT_ID"]}~#{charge.uid}~#{charge.amount}~COP"
      Digest::MD5.hexdigest(msg)
    end
end
