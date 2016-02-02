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

#import "VBTableViewCell.h"

#import <UIKit+VBProgrammaticCreation.h>

@implementation VBTableViewCell

- (instancetype) init {
    self = [super init];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (instancetype) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (instancetype) initWithStyle:(UITableViewCellStyle)style
               reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style
                reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupUI];
    }
    return self;
}

#pragma mark - reuse identifier
- (NSString *) reuseIdentifier {
    return [self.class reuseIdentifier];
}

+ (NSString *) reuseIdentifier {
    return NSStringFromClass([self class]);
}

#pragma mark - setup
- (void) setupUI {
    
}

#pragma mark - height
+ (CGFloat) estimatedHeight {
    return UITableViewAutomaticDimension;
}

#pragma mark - color
- (UIColor *) selectedBackgroundColor {
    return self.selectedBackgroundView.backgroundColor;
}

- (void) setSelectedBackgroundColor:(UIColor *)selectedBackgroundColor {
    if (selectedBackgroundColor) {
        UIView* view = [UIView viewWithFrameAny];
        view.backgroundColor = selectedBackgroundColor;
        self.selectedBackgroundView = view;
    }else{
        self.selectedBackgroundView = nil;
    }
}

@end
