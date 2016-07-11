#
# Be sure to run `pod lib lint TYBlurImage.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'TYBlurImage'
  s.version          = '1.2.1'
  s.summary          = 'An easy way to set up blur effect and play the animation.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

#   s.description      = <<-DESC
# TODO: Add long description of the pod here.
#                        DESC

  s.homepage         = 'https://github.com/luckytianyiyan/TYBlurImage'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'luckytianyiyan' => 'luckytianyiyan@gmail.com' }
  s.source           = { :git => 'https://github.com/luckytianyiyan/TYBlurImage.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/luckytianyiyan'

  s.ios.deployment_target = '7.0'

  s.source_files = 'TYBlurImage/Classes/**/*'

  # s.resource_bundles = {
  #   'TYBlurImage' => ['TYBlurImage/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
