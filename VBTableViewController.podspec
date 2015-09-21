#
# Be sure to run `pod lib lint MyLib.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "VBTableViewController"
  s.version          = "0.1.0"
  s.summary          = "VBTableViewController"
  s.description      = <<-DESC
VBTableViewController extends UITableViewController by adding pagination, pull-to-refresh and other useful features.
                       DESC
  s.homepage         = "https://github.com/valnoc/VBTableViewController"
  s.license          = 'MIT'
  s.author           = { "Valeriy Bezuglyy" => "valnocorner@gmail.com" }
  s.source           = { :git => "https://github.com/valnoc/VBTableViewController.git", :tag => "v#{s.version}" }

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'VBTableViewController/**/*'

  s.dependency 'WZProtocolInterceptor', '~> 0.1'

end
