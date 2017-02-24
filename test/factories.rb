# require 'pry'
# Per Chris, what does this do?
#     It defines FactoryGirl factories (object to test with) for use in the tests
# Chris said if I wanted to shorten the amount of data I'm looking at, I can
# set paragraphs to 1
#
FactoryGirl.define do
  factory :note do
    title { Faker::Book.title }
    body  { Faker::Hipster.paragraphs(6).join("\n\n") }

    transient do
      tag_count   5
    end

    factory :note_with_tags do
      after(:create) do |job, evaluator|
        evaluator.tag_count.times do
          job.tags << Tag.find_or_initialize_by(name: Faker::Company.buzzword.gsub(%r(\s), "_"))
        end
      end
    end

  end

end

FactoryGirl.define do
  factory :tag do
    name { Faker::Company.buzzword.gsub(%r(\s), "_") }
  end


end
