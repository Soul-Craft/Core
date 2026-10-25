require 'test_helper'

class InviteMailerTest < ActionMailer::TestCase
  test "invite_mail" do
    mail = InviteMailer.invite_mail('new@example.com', 'Acme')
    assert_equal 'Join CORE', mail.subject
    assert_equal [ 'new@example.com' ], mail.to
    assert_equal [ 'developers@corecloudapp.com' ], mail.from
    assert_match %r{welcome/new_user\?email=new@example\.com&(amp;)?org=Acme}, mail.text_part.body.to_s
  end
end
