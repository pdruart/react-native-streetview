require 'json'

package = JSON.parse(File.read(File.join(__dir__, 'package.json')))

Pod::Spec.new do |s|
  s.name         = "NSTStreetView"
  s.version      = package['version']
  s.summary      = package['description']
  s.license      = package['license']

  s.authors      = package['author']
  s.homepage     = package['repository']['url']
  s.platform     = :ios, "9.0"
  s.ios.deployment_target = '9.0'
  s.tvos.deployment_target = '10.0'

  s.source       = { :git => "https://github.com/pdruart/react-native-streetview.git", :tag => "v#{s.version}" }
  s.source_files  = "ios/**/*.{h,m}"
  s.dependency          'React'
  s.dependency 'GoogleMaps', '3.1.0'
  s.dependency 'Google-Maps-iOS-Utils', '2.1.0'
end
