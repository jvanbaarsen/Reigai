module Sorcery
  module TestHelpers
    module Rails
      def login_user_post(email, password = 'secret')
        page.driver.post(login_url, {email: email, password: password})
      end

    end
  end
end
