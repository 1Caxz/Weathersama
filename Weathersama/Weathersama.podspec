Pod::Spec.new do |s|
  s.platform = :ios, '9.0'
  s.ios.deployment_target = "9.0"
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
  s.source_files = "Weathersama/**/*.{swift,h}"
  s.pod_target_xcconfig = { 'SWIFT_VERSION' => '4.0' }
  s.ios.deployment_target = '9.0'
end
