module ExceptionHandler
  extend ActiveSupport::Concern

   # Define custom error subclasses - rescue catches `StandardErrors` 
  class AuthenticationError < StandardError; end
  class MissingToken < StandardError; end
  class InvalidToken < StandardError; end
  class ExpiredSignature < StandardError; end
  class DecodeError < StandardError; end
  
  included do
    # Define custom handlers
    rescue_from Exception, :with => :render_error
    rescue_from Mongoid::Errors::DocumentNotFound, with: :four_twenty_two
    rescue_from ExceptionHandler::MissingToken, with: :missing_token
    rescue_from ExceptionHandler::InvalidToken, with: :invalid_token
    rescue_from ExceptionHandler::ExpiredSignature, with: :four_ninety_eight
    rescue_from ExceptionHandler::DecodeError, with: :four_zero_one
    rescue_from ExceptionHandler::AuthenticationError, with: :unauthorized_request
  end

  private

  def render_error(exp)
    Rails.logger.info "---Exception------#{exp.inspect}------------------"
    render json: {error: "Something went wrong"}, status: :unprocessable_entity
  end  

  # JSON response with message; Status code 422 - unprocessable entity
  def four_twenty_two(e)
   render json: { message: e.message }, status: :unprocessable_entity
  end

  #----Written common resuable methods for rendering same content---
  [:four_zero_one, :missing_token, :invalid_token].each do |method_name|
    define_method method_name do |arg|
      Rails.logger.info "-----Exception------#{arg.inspect}------------------------"
      render json: { message: "Invalid token" }, status: :unprocessable_entity  
    end
  end  
 

  def four_ninety_eight(e)
    Rails.logger.info "-----Exception------#{e.inspect}------------------------"
    render json: { message: "Session expired" }, status: :unauthorized
  end

  def unauthorized_request(e)
    Rails.logger.info "-----Exception------#{e.inspect}------------------------"
    render json: { message: "You are not authorized to perform this action" }, status: :unauthorized
  end


end


