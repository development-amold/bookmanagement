module JsonWebToken
 	class << self
	    def encode(payload, exp = 10.hours.from_now)
	      # set token expiration time 
	      payload[:exp] = exp.to_i
	       # this encodes the user data(payload) with our secret key
	      JWT.encode(payload, Rails.application.secrets.secret_key_base,'HS256')
	    end

	    def decode(token)
	     	#decodes the token to get user data (payload)
			body = JWT.decode(token, Rails.application.secrets.secret_key_base,'HS256')[0]
			HashWithIndifferentAccess.new body

		    rescue JWT::ExpiredSignature, JWT::VerificationError => e
		      raise ExceptionHandler::ExpiredSignature, e.message   #----Added common custom exception
		    rescue JWT::DecodeError, JWT::VerificationError => e
		      raise ExceptionHandler::DecodeError, e.message
		end
	end	
end