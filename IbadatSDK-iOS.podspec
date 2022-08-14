#
# Be sure to run `pod lib lint IbadatSDK-iOS.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'IbadatSDK-iOS'
  s.version          = '0.1.0'
  s.summary          = 'IbadatSDK-iOS is a framework for islamic solution.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      =  "TODO: Add long description of the pod here.  IbadatSDK-iOS is a framework for islamic solution. Dua, Surah, Salat time, Roja time, Tashbi and many more option"

  s.homepage         = 'https://github.com/gakkmediabd/IbadatSDK-iOS'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'MD Azizur Rahman' => 'azizur.gakk@gmail.com' }
  s.source           = { :git => 'https://github.com/gakkmediabd/IbadatSDK-iOSs.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '10.0'
  s.swift_versions = '4.0'
  s.source_files = 'IbadatSDK-iOS/Classes/**/*'
  
  #s.resource_bundles = {
  #   'IbadatSDK-iOS' => ['IbadatSDK-iOS/Assets/*.png']
  #}

  #s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
