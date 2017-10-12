Pod::Spec.new do |s|
  s.name = 'Weathersama'
  s.version = '1.1.1'
  s.license = 'MIT'
  s.summary = 'Elegant library for access openweathermap.org with google geocode and class mode inside.'
  s.homepage = 'https://github.com/icaksama/Weathersama'
  s.social_media_url = 'http://twitter.com/icaksama'
  s.authors = { 'icaksama' => 'icaksama@gmail.org' }
  s.source = { :git => 'https://github.com/icaksama/Weathersama.git', :tag => s.version }
  s.platform = :ios, '9.0'
  s.ios.deployment_target = '9.0'
  s.source_files = 'Weathersama/Weathersama/**/*.{swift,h}'

  s.dependency 'Alamofire', '~> 4.5'

end
