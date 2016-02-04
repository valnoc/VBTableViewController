//
//    The MIT License (MIT)
//
//    Copyright (c) 2015 Valeriy Bezuglyy.
//
//    Permission is hereby granted, free of charge, to any person obtaining a copy
//    of this software and associated documentation files (the "Software"), to deal
//    in the Software without restriction, including without limitation the rights
//    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//    copies of the Software, and to permit persons to whom the Software is
//    furnished to do so, subject to the following conditions:
//
//    The above copyright notice and this permission notice shall be included in all
//    copies or substantial portions of the Software.
//
//    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//    SOFTWARE.
//

#import <UIKit/UIKit.h>

@protocol VBTableViewDataSource <UITableViewDataSource>

@end

@protocol VBTableViewDelegate <UITableViewDelegate>

@optional
- (void) tableViewDidScrollToNextPage:(UITableView*)tableView;
- (void) tableViewDidStartPullToRefresh:(UITableView*)tableView;

@end

/**
 *  VBTableViewController extends UITableViewController by adding pagination, pull-to-refresh and other useful features.
 */
@interface VBTableViewController : UITableViewController

/**
 * Use this dataSource property instead of tableView.dataSource
 */
@property (nonatomic, weak) id<VBTableViewDataSource> dataSource;

/**
 * Use this delegate property instead of tableView.delegate
 */
@property (nonatomic, weak) id<VBTableViewDelegate> delegate;

#pragma mark - table
/**
 * Reload visible rows animated
 */
- (void) reloadVisibleCells;

/**
 * Change the height of tableView.tableHeaderView using constraints. This is done automatically only for section headers.
 */
- (void) fitTableHeaderView;

/**
 * A short version of "register class for reuse identifier". Calls +reuseIdetifier if classToRegister is a subclass of VBTableViewCell, else
 */
- (void) registerClassForCell:(Class) classToRegister;

#pragma mark - pagination
/**
 * If pagination is enabled, activity indicator will be used as tableFooterView. Delegate will be notified with <i>-tableViewDidScrollToNextPage:</i>
 */
@property (nonatomic, assign) BOOL paginationEnabled;

/**
 * Setting this property to YES blocks delegate calls, but do not hide activity indicator.
 */
@property (nonatomic, assign) BOOL paginationIsLoadingNextPage;

#pragma mark - pullToRefresh
/**
 * If pullToRefresh is enabled, the standard UIRefreshControl is used as self.refreshControl.
 */
@property (nonatomic, assign) BOOL pullToRefreshEnabled;

/**
 * Updates the refreshControl state.
 */
- (void) beginPullToRefresh;

/**
 * Updates the refreshControl state.
 */
- (void) endPullToRefresh;

#pragma mark - empty cells
/**
 * if NO (<b>by default</b>), hides empty cells. Useful with tableView plain style.
 */
@property (nonatomic, assign) BOOL showEmptyCells;

@end
