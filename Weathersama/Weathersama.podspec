Pod::Spec.new do |s|
  s.platform = :is
  s.ios.deployment_target = "8.0"
  s.name = "Weathersama"
  s.summary = "Weathersama is instance library for access weather on openweathermap.org"
  s.requires_arc = true
  s.version = "1.0"
  s.license = { :type => "MIT", :file => "LICENSE" }
  s.author = { "icaksama" => "icaksama@gmail.com" }
  s.homepage = "https://github.com/icaksama/Weathersama"
  s.source = { :git => "https://github.com/icaksama/Weathersama.git", :tag => "#{s.version}"}
  s.framework = "UIKit"
  s.dependency "Alamofire", "~> 4.5"
  s.source_files = "Weathersama/**/*.{swift}"
  s.resources = "Weathersama/**/*.{png,jpeg,jpg,storyboard,xib}"
end
