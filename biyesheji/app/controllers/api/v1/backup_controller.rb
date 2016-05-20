class Api::V1::BackupController < Api::BaseController
  #this need user_token
  def backup
  token = params[:token]
  if !token.present?
     render_message(0,"token is null")
     return
  end
  user = User.find_by(:user_token => token)
  if !user.present?
    render_message(0,"token is invalid!")
    return
  end
  user_id = user.id
  title = params[:title]
  body = params[:body]
  diary_id = params[:id]
begin
  picture = params[:picture]
  sound = params[:sound]
rescue Exception => e
 puts "#{e.message}"
end
  origin = Diary.where("diary_id = ? and uid = ?",diary_id,user_id).first
  if origin.present?
    origin.title = title
    origin.content = body
    origin.photo = picture
    origin.sound = sound
    if origin.save
      render_message(1,"#{diary_id} is backed up successfully")
      return
    else
      render_message(0,"#{diary_id} is backed up failed")
      return
    end
  end

  diary = Diary.new
  diary.uid = user_id
  diary.title = title
  diary.content = body
  diary.diary_id = diary_id
  diary.photo = picture
  diary.sound = sound
  if diary.save
    render_message(1,"#{diary_id} is saved successfully")
    return
  else
    render_message(0,"#{diary_id} is saved failed")
    return
  end
  end

  def recovery
    token = params[:token].present? ? params[:token] : 0
    username = params[:name]
    user = User.find_by(:user_token => token)
    if !user.present?
      render_message(0,"token is invalid!")
      return
    end
    if user.name != username
      render_message(2,"token or name error!")
      return
    end
    
    diaries = Diary.where("uid = ?",user.id)
    if diaries.present?
      result = Array.new
      diaries.each do |d|
        row = {}
       
        row['title'] = d.title
        row['body'] = d.content
        row['diary_id'] = d.diary_id
        row['pic_path'] = d.photo.url.present? ? d.photo.url : ""
        row['voice_path'] = d.sound.url.present? ? d.sound.url : ""
        result.push row
      end
      render_message2(1,"recovery success!",result)
      return
    end
  end
  #before back up,checkout the max diary_id
  def before_backup
  end 
end
