module Sorcery
  module TestHelpers
    module Rails
      def login_user_post(email, password = 'secret')
        page.driver.post(login_url, {email: email, password: password})
      end

      def login_user(user)
        login_user_post(user.email)
        return user
      end
    end
  end
end
