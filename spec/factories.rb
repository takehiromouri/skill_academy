FactoryGirl.define do
  factory :rating do
    stars 5
    comment "Awesome!"    
  end

  factory :enrollment do
    
  end
  factory :user do
    first_name "John"
    last_name  "Doe"
    sequence :email do |n|
      "random#{n}@email.com"
    end
    password "codingiscool"
    password_confirmation "codingiscool"
  end

  factory :course do
    title "Title"
    description "lorem ipsum"
    price 100
    start_time DateTime.now + 1.hour
    end_time DateTime.now + 2.hour
    category :Business
    target "Target"
    location "TECHRISE Office"
    address "Kupondole, Jwagal"
    average_rating 4
  end

  factory :invalid_course, class: 'Course' do
    title "Title"
    description "lorem ipsum"
    price 100
    start_time nil
    end_time nil
    category :Business
    target "Target"
    location "TECHRISE Office"
    address "Kupondole, Jwagal"
  end
end