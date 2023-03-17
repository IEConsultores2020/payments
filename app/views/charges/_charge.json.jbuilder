json.extract! charge, :id, :uid, :status, :payment_method, :amount, :error_message, :response, :created_at, :updated_at
json.url charge_url(charge, format: :json)
