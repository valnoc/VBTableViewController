VBTableViewController
===========
[![](https://img.shields.io/cocoapods/v/VBTableViewController.svg)]()

<b>VBTableViewController</b> extends UITableViewController by adding pagination, pull-to-refresh and other useful features.

<b>VBTableViewCell</b> is a base class for cells. Each cell contains only apporpriate <b>VBTableViewCellView</b> as a subview. 
The idea is to setup UI of VBTableViewCellView by setting its item property (which calls updateUI).

<b>VBTableViewHeader</b> uses the same idea as VBTableViewCell.

## How to install
Use CocoaPods

    pod 'VBTableViewController'

or

Drag VBTableViewController dir into your project.

## License
VBTableViewController is available under the MIT license. See the LICENSE file for more info.
