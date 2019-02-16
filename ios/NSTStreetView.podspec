require 'json'

package = JSON.parse(File.read(File.join(__dir__, 'package.json')))

Pod::Spec.new do |s|
  s.name         = "react-native-streetview"
  s.version      = package['version']
  s.summary      = "React Native Street View component for iOS + Android"

  s.authors      = { "vpontis" => "victor@pont.is" }
  s.homepage     = "https://github.com/vpontis/react-native-streetview#readme"
  s.license      = "MIT"
  s.platform     = :ios, "8.0"

  s.source       = { :git => "https://github.com/vpontis/react-native-streetview.git", :branch => "expo" }
  s.source_files  = "lib/ios/**/*.{h,m}"
  s.compiler_flags = '-DHAVE_GOOGLE_MAPS=1', '-DHAVE_GOOGLE_MAPS_UTILS=1', '-fno-modules'

  s.dependency 'React'
  s.dependency 'GoogleMaps', '2.5.0'
  s.dependency 'Google-Maps-iOS-Utils', '2.1.0'
end

