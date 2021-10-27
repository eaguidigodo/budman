FactoryBot.define do
    factory :user do
      name { "user1" }
      email { "user1@user.com" }
      password { "userpass" }
      admin {false}
    end

    factory :admin_user do
        name { "admin" }
        email { "admin@user.com" }
        password { "userpass" }
        admin {true}
      end
  
    factory :second_user, class: User do 
      username { "wunderkind" }
      email { "wunderkind@gmail.com" }
      password { "anicetenselme" }
      is_admin {"true"}
    end
  
    factory :third_user, class: User do 
      username { "nuxlikage" }
      email { "nuxlikage@gmail.com" }
      password { "anicetenselme" }
      is_admin {"false"}
    end
  end
  