namespace :db do
  task populate: :environment do
    Task.destroy_all
    User.destroy_all

    ActiveRecord::Base.transaction do
      5.times { FactoryGirl.create :user, created_at: rand(5).days.ago }

      User.all.each do |user|
        5.times do
          Task.create(
            name: Faker::Hipster.sentence(3, true, 4),
            description: Faker::Hipster.paragraph(2, true, 4),
            user: user
          )
        end
      end
    end
  end
end

