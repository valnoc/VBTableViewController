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


#import "VBTableViewController.h"

#define kTableViewControllerCellEmptyListIdentifier @"kTableViewControllerCellEmptyListIdentifier"

@interface VBTableViewController ()

@property (nonatomic, strong) UIView* paginationView;
@property (nonatomic, strong) UIView* prePaginationFooterView;

@property (nonatomic, strong) NSLayoutConstraint* cnstrEmptyListViewHeight;

@end

@implementation VBTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.sectionHeaderHeight = UITableViewAutomaticDimension;
    self.tableView.sectionFooterHeight = UITableViewAutomaticDimension;
    
    self.showEmptyCells = self.showEmptyCells;
    
    [self.tableView registerClass:[UITableViewCell class]
           forCellReuseIdentifier:kTableViewControllerCellEmptyListIdentifier];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void) viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    self.cnstrEmptyListViewHeight.constant = self.view.bounds.size.height;
}

#pragma mark - table
- (void) reloadVisibleCells {
    [self.tableView reloadRowsAtIndexPaths:[self.tableView indexPathsForVisibleRows]
                          withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void) fitTableHeaderView {
    UIView* header = self.tableView.tableHeaderView;
    [header setNeedsLayout];
    [header layoutIfNeeded];
    
    CGFloat height = [header systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    CGRect frame = header.frame;
    
    frame.size.height = height;
    header.frame = frame;
    self.tableView.tableHeaderView = header;
}

#pragma mark - pullToRefresh
- (void) setPullToRefreshEnabled:(BOOL)pullToRefreshEnabled {
    _pullToRefreshEnabled = pullToRefreshEnabled;
    if (_pullToRefreshEnabled) {
        UIRefreshControl* p2RView = [UIRefreshControl new];
        [p2RView addTarget:self
                    action:@selector(pullToRefreshEvent:)
          forControlEvents:UIControlEventValueChanged];
        self.refreshControl = p2RView;
    }else{
        self.refreshControl = nil;
    }
}

- (void) pullToRefreshEvent:(id)sender {
    if ([self.delegate respondsToSelector:@selector(tableViewDidStartPullToRefresh:)]) {
        [self.delegate tableViewDidStartPullToRefresh:self.tableView];
    }
}

- (void) beginPullToRefresh {
    [self.refreshControl beginRefreshing];
}
- (void) endPullToRefresh {
    [self.refreshControl endRefreshing];
}

#pragma mark - empty cells
- (void) setShowEmptyCells:(BOOL)showEmptyCells {
//    if (_showEmptyCells != showEmptyCells) {
        _showEmptyCells = showEmptyCells;
        if (_showEmptyCells) {
            self.tableView.tableFooterView = nil;

        }else if (self.tableView.tableFooterView == nil) {
            UIView* view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
            view.backgroundColor = [UIColor clearColor];
            self.tableView.tableFooterView = view;
        }
//    }
}

#pragma mark - pagination
- (void) setPaginationEnabled:(BOOL)paginationEnabled {
    _paginationEnabled = paginationEnabled;
    if (_paginationEnabled) {
        self.prePaginationFooterView = self.tableView.tableFooterView;
        self.tableView.tableFooterView = self.paginationView;
    }else{
        self.tableView.tableFooterView = self.prePaginationFooterView;
        if (self.showEmptyCells == NO && self.tableView.tableFooterView == nil) {
            self.showEmptyCells = self.showEmptyCells;
        }
    }
}
- (UIView *) paginationView {
    if (_paginationView == nil) {
        UIView* view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
        view.backgroundColor = [UIColor clearColor];
        
        UIActivityIndicatorView* aiv = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [aiv startAnimating];
        [view addSubview:aiv
              withLayout:@{VBAutolayoutAttributeTop:        @"0",
                           VBAutolayoutAttributeBottom:     @"0",
                           VBAutolayoutAttributeLeading:    @"0",
                           VBAutolayoutAttributeTrailing:   @"0"}];
        _paginationView = view;
    }
    return _paginationView;
}
- (void) paginationOffsetCheck:(CGFloat)contentOffsetY {
    if (self.paginationEnabled &&
        self.paginationIsLoadingNextPage == NO &&
        [self contentOffsetYAtBottom:contentOffsetY]) {
        
        VBLog(@"YES");
        if ([self.delegate respondsToSelector:@selector(tableViewDidScrollToNextPage:)]) {
            [self.delegate tableViewDidScrollToNextPage:self.tableView];
        }
    }
}
- (BOOL) contentOffsetYAtBottom:(CGFloat)contentOffsetY {
    double screenHeight = [[UIScreen mainScreen] bounds].size.height;
    double bottomOffset = self.tableView.contentSize.height - self.tableView.bounds.size.height - contentOffsetY;
    return bottomOffset <= (screenHeight / 4.0f);
}

- (void) scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
//    VBLog(@"");
    [self paginationOffsetCheck:scrollView.contentOffset.y];
    
    if ([self.delegate respondsToSelector:@selector(scrollViewDidEndDecelerating:)]) {
        [self.delegate scrollViewDidEndDecelerating:scrollView];
    }
}

- (void) scrollViewDidEndDragging:(UIScrollView *)scrollView
                   willDecelerate:(BOOL)decelerate {
//    VBLog(@"");
    [self paginationOffsetCheck:scrollView.contentOffset.y];

    if ([self.delegate respondsToSelector:@selector(scrollViewDidEndDragging:willDecelerate:)]) {
        [self.delegate scrollViewDidEndDragging:scrollView
                                 willDecelerate:decelerate];
    }
}

- (void) scrollViewWillEndDragging:(UIScrollView *)scrollView
                      withVelocity:(CGPoint)velocity
               targetContentOffset:(inout CGPoint *)targetContentOffset {
//    VBLog(@"");
    [self paginationOffsetCheck:targetContentOffset->y];

    if ([self.delegate respondsToSelector:@selector(scrollViewWillEndDragging:withVelocity:targetContentOffset:)]) {
        [self.delegate scrollViewWillEndDragging:scrollView
                                    withVelocity:velocity
                             targetContentOffset:targetContentOffset];
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if ([self.datasource respondsToSelector:@selector(numberOfSectionsInTableView:)]) {
        return [self.datasource numberOfSectionsInTableView:tableView];
    }else{
        return 1;

    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.datasource tableView:tableView
                numberOfRowsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.datasource tableView:tableView
                cellForRowAtIndexPath:indexPath];
}

#pragma mark - UITableViewDelegate
#pragma mark height
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.delegate respondsToSelector:@selector(tableView:estimatedHeightForRowAtIndexPath:)]) {
        return [self.delegate tableView:tableView estimatedHeightForRowAtIndexPath:indexPath];
    }else{
        return UITableViewAutomaticDimension;
    }
}

#pragma mark selection
- (NSIndexPath *) tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(tableView:willSelectRowAtIndexPath:)]) {
        return [self.delegate tableView:tableView willSelectRowAtIndexPath:indexPath];
    }else{
        return indexPath;
    }
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
        [self.delegate tableView:tableView didSelectRowAtIndexPath:indexPath];
    }
}

- (NSIndexPath *) tableView:(UITableView *)tableView willDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(tableView:willDeselectRowAtIndexPath:)]) {
        return [self.delegate tableView:tableView willDeselectRowAtIndexPath:indexPath];
    }else{
        return indexPath;
    }
}

- (void) tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(tableView:didDeselectRowAtIndexPath:)]) {
        [self.delegate tableView:tableView didDeselectRowAtIndexPath:indexPath];
    }
}

#pragma mark header/footer
- (CGFloat) tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section {
    if ([self.delegate respondsToSelector:@selector(tableView:estimatedHeightForHeaderInSection:)]) {
        return [self.delegate tableView:tableView estimatedHeightForHeaderInSection:section];
    }else{
        return UITableViewAutomaticDimension;
    }
}
- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if ([self.delegate respondsToSelector:@selector(tableView:viewForHeaderInSection:)]) {
        return [self.delegate tableView:tableView viewForHeaderInSection:section];
    }else{
        return nil;
    }
}

- (CGFloat) tableView:(UITableView *)tableView estimatedHeightForFooterInSection:(NSInteger)section {
    if ([self.delegate respondsToSelector:@selector(tableView:estimatedHeightForFooterInSection:)]) {
        return [self.delegate tableView:tableView estimatedHeightForFooterInSection:section];
    }else{
        return UITableViewAutomaticDimension;
    }
}
- (UIView *) tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if ([self.delegate respondsToSelector:@selector(tableView:viewForFooterInSection:)]) {
        return [self.delegate tableView:tableView viewForFooterInSection:section];
    }else{
        return nil;
    }
}

#pragma mark display
- (void) tableView:(UITableView *)tableView
   willDisplayCell:(UITableViewCell *)cell
 forRowAtIndexPath:(NSIndexPath *)indexPath {
 
    if ([self.delegate respondsToSelector:@selector(tableView:willDisplayCell:forRowAtIndexPath:)]) {
        [self.delegate tableView:tableView
                 willDisplayCell:cell
               forRowAtIndexPath:indexPath];
    }
}

@end
