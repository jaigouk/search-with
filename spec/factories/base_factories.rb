FactoryGirl.define do
  factory :tag do
    title { FFaker::CheesyLingo.words.first.downcase }
  end

  factory :location do
    name { FFaker::FFaker::InternetSE.user_name_random }
    city { FFaker::Address.city.downcase }
    line1 { FFaker::Address.street_address }
  end

  factory :activity do
    title { FFaker::DizzleIpsum.words.sample.capitalize }
    about { FFaker::HipsterIpsum.paragraph }
    price { (1..9).to_a.sample * 100 }
    start_months_old 4
    end_months_old 9
    camp { FFaker::Boolean.random }
    drop_in { FFaker::Boolean.random }
    date_night { FFaker::Boolean.random }
    indoor { FFaker::Boolean.random }
    outdoor { FFaker::Boolean.random }
  end


  factory :activity_tag do
    activity
    tag
  end

  factory :activity_location do
    activity
    location
  end
end
