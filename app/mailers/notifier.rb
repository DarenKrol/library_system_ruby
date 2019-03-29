class Notifier < ApplicationMailer

  default from: "no-reply@librarysystem.com"

  def send_notification(email, user_name, book_name)
    @book_name = book_name
    @user_name = user_name
    mail(to: email, subject: "Książka #{book_name} jest dostępna!")
  end
end
