module TopicsHelper
  def user_is_authorized_for_topics?
    current_user && current_user.admin?
  end

  def moderator_authorized_for_update?
    if current_user
      current_user.moderator?
    else
      false
    end
  end
end
