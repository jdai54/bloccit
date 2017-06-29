class FavoriteMailer < ApplicationMailer
  default from: "jdai54@gmail.com"

  def new_comment(user, post, comment)

  # #18
    if @comment
      headers["Message-ID"] = "<comments/#{comment.id}@your-app-name.example>"
      headers["In-Reply-To"] = "<post/#{post.id}@your-app-name.example>"
      headers["References"] = "<post/#{post.id}@your-app-name.example>"

      @user = user
      @post = post
      @comment = comment

      # #19
      mail(to: user.email, subject: "New comment on #{post.title}")
    else
      false
    end
  end
end
