require 'digest/md5'

class Api::V1::UserController < Api::BaseController
  def login
    name = params[:name].to_s
    passwd = params[:password].to_s
    if name.blank? || passwd.blank?
      render_message(0,"name or password is empty!")
      return
    end
    user = User.find_by(:name => name)
    if user.blank?
      render_message(0,"name is not found!")
      return
    end
    if user.passwd != md5(passwd)
      render_message(0,"password is incorrect!")
      return
    end

    timestamp = Time.new.to_i.to_s
    user_token = md5(name+passwd+timestamp)
    user[:user_token] = user_token
    if user.save
      result = {}
      result['token'] = user_token
      render_message2(1,"#{name} login success!",result)
      return
    end
    render_message(2,"something error!")
    
  end
  
  def register
    name = params[:name].to_s
    passwd = params[:password].to_s
     
    if name.blank? || passwd.blank?
      render_message(0,"name or password is empty!")
      return
    end
    tuser = User.find_by(:name => name)
    if !tuser.blank?
      render_message(3,"name is repeatedly!")
      return
    end
    user = User.new
    user['name'] = name
    user['passwd'] = md5(passwd)
    timestamp = Time.new.to_i.to_s
    user_token = md5(name+passwd+timestamp)
    user['user_token'] = user_token
    if user.save
      result = {}
      result['token'] = user_token
      render_message2(1,"#{name} register success!",result)
      return
    end
    render_message(2,"something error!")
  end
  
  def md5(token)
    Digest::MD5.hexdigest(token)
  end
end
