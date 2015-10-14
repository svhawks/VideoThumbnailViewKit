#
# Be sure to run `pod lib lint youtube-parser.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "VideoThumbView"
  s.version          = "0.0.1"
  s.summary          = "Video Thumb ScrollView"
  s.homepage         = "https://github.com/toygar/VideoThumbView"
  s.license          = 'MIT'
  s.author           = { "Toygar Dündaralp" => "tdundaralp@gmail.com" }
  s.social_media_url = 'https://twitter.com/ToygarDndaralp'
  s.source           = { :git => "https://github.com/toygar/VideoThumbView.git", :tag => s.version.to_s }
  s.platform         = :ios, '8.0'
  s.requires_arc     = true
  s.source_files     = 'VideoThumbView/*.swift'
  s.xcconfig         = { 'HEADER_SEARCH_PATHS' => '$(SRCROOT)/VideoThumbView' }
end
