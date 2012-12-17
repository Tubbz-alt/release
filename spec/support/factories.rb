FactoryGirl.define do
  factory :release do
    summary "release summary"
    notes "release notes"
    deploy_at { Time.now }
    user

    after(:build) do |release|
      release.tasks << FactoryGirl.build(:task, :release_id => release.id)
    end
  end

  factory :task do
    application
    sequence :version
    description "deploy this"
  end

  factory :application do
    sequence(:name) {|n| "Application #{n}"}
    sequence(:repo) {|n| "alphagov/application-#{n}" }
  end

  factory :deployment do
    sequence(:version) { |n| "release_#{n}" }
    environment "production"
  end

  factory :user do
    name "Stub User"
    sequence(:email) {|n| "winston-#{n}@gov.uk" }
    permissions { Hash[GDS::SSO::Config.default_scope => ["signin"]] }
  end
end
