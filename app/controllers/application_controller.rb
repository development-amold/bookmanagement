class ApplicationController < ActionController::API
	include ExceptionHandler  #----Added Custom Exception Responses to client
	before_action :authorize_api_request

	def search
		@res = []
		if params.has_key?(:q) && !params[:q].blank?
			@res = Author.only(:name).where(:name =>/.*#{params[:q]}.*/i).to_a + Book.only(:name).where(:name =>/.*#{params[:q]}.*/i).to_a + Review.only(:name).where(:name =>/.*#{params[:q]}.*/i).to_a  	
		end
		render :json => @res
	end	

	private

    def authorize_api_request
        @current_author = AuthorizeApiRequest.call(request.headers).result
        render json: { error: 'Not Authorized' }, status: 401 unless @current_author
    end   

    def current_author
        @current_user ||= authorize_api_request
    end

end
