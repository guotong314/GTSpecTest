#
# Be sure to run `pod lib lint GTSpec.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'GTSpec'
  s.version          = '0.7.7'
  s.summary          = 'A short description of GTSpec.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/guotong314/GTSpecTest'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '郭通' => 'guotong314@gmail.com' }
  s.source           = { :git => 'https://github.com/guotong314/GTSpecTest.git', :tag => s.version}
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '7.0'

  s.requires_arc = true

  #s.public_header_files = 'Example/GTSpec/Classes/Defines/*.h'  #公开头文件地址
  s.prefix_header_file =  'Example/GTSpec/GTSpec-Prefix.pch'
  s.source_files = 'Example/GTSpec/Classes/**/*'
  s.resources = 'Example/GTSpec/Resources/*.xcassets'


  #s.resource_bundles = {
  #  'GTSpec' => ['Example/GTSpec/Resources/**/*]
  #}

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
  #s.dependency 'KLSwitch', '~> 1.5'

  s.dependency 'KVOController'
  s.dependency 'BlocksKit'
  s.dependency 'Masonry'
  s.dependency 'AFNetworking',      '~> 2.0'
  s.dependency 'SDWebImage',        '~> 3.7.3'
  s.dependency 'Objective-LevelDB'
  s.dependency 'AutoCoding'

end
