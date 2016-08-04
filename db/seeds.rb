require 'ffaker'
15.times do
  random = FFaker::CheesyLingo.words.first.downcase
  tag  = Tag.new
  tag.title = loop do
    break random unless Tag.exists?(title: random.first)
  end
  tag.save
end


100.times do |i|
  city = FFaker::Address.city.downcase
  addr = FFaker::Address.street_address
  Location.create(name: "#{city}-#{i}", city: city, line1: addr)
end


m = (1..12).to_a
1000.times do |i|
  picked = m.sample
  activity = Activity.create(
    title: "#{FFaker::DizzleIpsum.words.sample.capitalize} #{i}",
    about: "#{i} #{FFaker::HipsterIpsum.paragraph}",
    price: (1..9).to_a.sample * 100,
    start_months_old: m.sample,
    end_months_old: m.split(picked).last.sample,
    camp: FFaker::Boolean.random,
    drop_in: FFaker::Boolean.random,
    date_night: FFaker::Boolean.random,
    indoor: FFaker::Boolean.random,
    outdoor: FFaker::Boolean.random
  )
  (0..3).to_a.sample.times do
    ActivityTag.create(activity_id: activity.id, tag_id: Tag.all.sample.id)
  end
  ActivityLocation.create(activity_id: activity.id, location_id: Location.all.sample.id)
end

