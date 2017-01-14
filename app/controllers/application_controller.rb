class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def redirect_to_last_or_url(url)
    if(session[:last_request])
      local_last_request = session[:last_request].dup.symbolize_keys
      session[:last_request] = nil

      redirect_to local_last_request[:url], local_last_request[:params]
    else
      redirect_to url
    end
  end

  def set_last_request(except: [])
    session[:last_request] = {
      url: request.original_url,
      params: params
    }

    except.each do |e|
      session[:last_request].except!(e)
    end
  end
end
