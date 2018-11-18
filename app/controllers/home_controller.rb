class HomeController < ActionController::API
	include Response
	include ExceptionHandler
	def login
		@author = Author.find_by(email: params[:author][:email]).try(:authenticate, params[:author][:password])
		if @author
			headers["X-Access-Token"] = JsonWebToken.encode(author_id: @author.id)
			json_response({success: "Logged in successfully"})
		else
			json_response({error: "Invalid credentials"},:unprocessable_entity)
		end
	end

	def sign_up
		# {email: params[:email], name: params[:name],:password => params[:password],:password_confirmation => params[:password_confirmation]  }
	    @author = Author.new(author_params)
	    if @author.save
	      headers["X-Access-Token"] = JsonWebToken.encode(author_id: @author.id)
	      json_response(@author,:created)
	    else
	    	json_response(@author.errors,:unprocessable_entity)
	    end		
	end

	def search
		@res = []
		if params.has_key?(:q) && !params[:q].blank?
			@res = Author.only(:name).where(:name =>/.*#{params[:q]}.*/i).to_a + Book.only(:name).where(:name =>/.*#{params[:q]}.*/i).to_a + Review.only(:name).where(:name =>/.*#{params[:q]}.*/i).to_a  	
		end
		json_response(@res)
	end

	private

    def author_params
    	params.require(:author).permit(:name,:email,:password, :password_confirmation,:author_bio, :pic, :academics, :awards)
    end	

end