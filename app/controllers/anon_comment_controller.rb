class AnonCommentController < AnonBoardController
  def initialize(*params)
    super(*params)
    @board_name='댓글'
  end

  def confirm_delete
    gg=self.show
    gid=gg.id
    @gid=gid
    gname=gg.class.name

    unless session[gname]
      session[gname]={}
    end

    unless session[gname][:guest_confirm_id]
      session[gname][:guest_confirm_id]=[]
    end

    if(params[:confirm])
      session[gname][:guest_confirm_id]<<gid
      redirect_to(:action=>'destroy',:id=>gid)
    end
  end

  def password_fail
    self.show
  end

  def password
    self._password(self.show,session[:next_action])
  end

  def privileges?
    self._privileges
  end

  protected

  def _privileges
    gg=self.show
    @gname=gg.class.name
    @gid=gg.id

    if(gg.user_id)
      if(current_user)
        if(current_user.id===gg.user_id)
          return true
        else
          return false
        end
      else
        return false
      end
    end

    unless session.key?(@gname)
      return false
    else
      if session[@gname][:guest_pass_id]
        unless session[@gname][:guest_pass_id].include?(@gid)
          return false
        end
      else
        return false
      end
    end

    return true
  end
end
