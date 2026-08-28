class GroupMailer < ApplicationMailer
  def event_mail(group, title, body)
    @group = group
    @title = title
    @body = body

    mail(
      to: @group.users.pluck(:email),
      subject: @title
    )
  end
end