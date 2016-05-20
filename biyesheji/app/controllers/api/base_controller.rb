class Api::BaseController < ApplicationController
  
  #1 success other failed
  def render_message(code,message)
    result = {}
    result['code'] = code
    result['message'] = message
    render json: result
  end

  def render_message2(code,message,res)
    result = {}
    result['code'] = code
    result['message'] = message
    result['result'] = res
    render json: result
  end
end
