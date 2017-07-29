module PayboxMoney
  module Payment
    class Init < ApiWrapper
      PERMITTED_PARAMS = %i(
        merchant_id
        order_id
        amount
        currency
        chech_url
        result_url
        refund_url
        capture_url
        request_method
        success_url
        failure_url
        success_url_method
        failure_url_method
        state_url
        state_url_method
        site_url
        payment_system
        lifetime
        encoding
        description
        user_phone
        user_contact_email
        user_email
        user_ip
        language
        testing_mode
        recurring_start
        recurring_lifetime
        salt
        sig
        secret_key
        status
        redirect_url
        redirect_url_type
        error_code
        error_description
      ).freeze

      REQUIRED_PARAMS = %i(
        merchant_id
        amount
        description
        salt
        sig
        secret_key
      ).freeze

      def initialize(params = {})
        sig = Signature.new(
          secret_key: params[:secret_key],
          url: INIT_PAYMENT_URL,
          params: params
        ).result
        super(
          PERMITTED_PARAMS,
          REQUIRED_PARAMS,
          INIT_PAYMENT_URL,
          params.merge(sig: sig)
        )
      end
    end
  end
end
