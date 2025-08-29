module ApplicationHelper
  def flagToString(flag,no_html=false)
    if no_html
      if flag
        return t(:flag_true)
      else
        return t(:flag_false)
      end
    else
      if flag
        return '<span class="flag_true">'+t(:flag_true)+'</span>'
      else
        return '<span class="flag_false">'+t(:flag_false)+'</span>'
      end
    end
  end

  def actionNameChange(action_name)
    case action_name
    when 'index'
      return t(:action_index)
    when 'new'
      return t(:action_new)
    when 'edit'
      return t(:action_edit)
    when 'show'
      return t(:action_show)
    else
    end
  end

  def manage_width(model)
    if can?(:delete, model) && can?(:update, model)
      return 'style="width:180px;"'
    else
      return 'style="width:90px"'
    end
  end

  def get_dt_format(date)
    return I18n.l date.to_date
  end
end
