FactoryBot.define do
  factory :post do
    body { FFaker::Lorem.phrase.truncate(199) }
    images do
      upload_files([
                     "spec/fixtures/images/1.jpg",
                     "spec/fixtures/images/2.jpg"
                   ])
    end
    association :user
  end
end

def upload_files(paths)
  paths.map do |path|
    Rack::Test::UploadedFile.new(path, 'image/jpeg')
  end
end
