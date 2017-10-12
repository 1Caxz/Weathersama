Pod::Spec.new do |s|
  s.name = 'Weathersama'
  s.version = '1.0.1'
  s.license = 'MIT'
  s.summary = 'Elegant library for access openweathermap.org with google geocode and class mode inside.'
  s.homepage = 'https://github.com/icaksama/Weathersama'
  s.social_media_url = 'http://twitter.com/icaksama'
  s.authors = { 'icaksama' => 'icaksama@gmail.org' }
  s.source = { :git => 'https://github.com/icaksama/Weathersama.git', :tag => s.version }

  s.ios.deployment_target = '9.0'
  s.osx.deployment_target = '10.10'
  s.tvos.deployment_target = '9.0'
  s.watchos.deployment_target = '2.0'

  s.source_files = 'Source/*.swift'
end
