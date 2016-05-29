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
  s.version          = "2.0.1"
  s.summary          = "VBTableViewController extends UITableViewController by adding pagination, pull-to-refresh and other useful features."
  s.description      = <<-DESC
VBTableViewController extends UITableViewController by adding pagination, pull-to-refresh and other useful features.

VBTableViewCell is a base class for cells. Each cell contains only apporpriate VBTableViewCellView as a subview. The idea is to setup UI of VBTableViewCellView by setting its item property (which calls updateUI).

VBTableViewHeader uses the same idea as VBTableViewCell.
                       DESC
  s.homepage         = "https://github.com/valnoc/VBTableViewController"
  s.license          = 'MIT'
  s.author           = { "Valeriy Bezuglyy" => "valnocorner@gmail.com" }
  s.source           = { :git => "https://github.com/valnoc/VBTableViewController.git", :tag => "v#{s.version}" }

  s.platform     = :ios, '8.1'
  s.requires_arc = true

  s.source_files = 'VBTableViewController/**/*{.h,.m}'

  s.dependency 'WZProtocolInterceptor', '~> 0.1'
  s.dependency 'VBException', '~> 1.0'
  s.dependency 'VBAutolayout', '~> 2.0'
  s.dependency 'UIKit+VBProgrammaticCreation', '~> 1.0'

end
