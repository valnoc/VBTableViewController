//
//    The MIT License (MIT)
//
//    Copyright (c) 2016 Valeriy Bezuglyy.
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

#import "VBTableViewHeader.h"

#import "UIKit+VBProgrammaticCreation.h"
#import "VBAutolayout.h"
#import "VBInvalidClassException.h"

@implementation VBTableViewHeader

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

- (instancetype) initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithReuseIdentifier:reuseIdentifier];
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
    if ([self.class itemViewClass]) {
        self.itemView = [[[self.class itemViewClass] alloc] initWithFrame:self.contentView.bounds];
        if ([self.itemView isKindOfClass:[VBTableViewHeaderView class]] == NO) {
            @throw [VBInvalidClassException exception];
        }
    }
}

+ (Class)itemViewClass {
    return [VBTableViewHeaderView class];
}

- (void) setItemView:(VBTableViewHeaderView *)itemView {
    _itemView = itemView;
    
    [self.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    if (self.itemView) {
        [self.contentView addSubview:self.itemView
                          withLayout:@{VBAutolayoutAttributeTop:        @"0",
                                       VBAutolayoutAttributeBottom:     @"0@999",
                                       VBAutolayoutAttributeLeading:    @"0",
                                       VBAutolayoutAttributeTrailing:   @"0"}];
    }
}

#pragma mark - height
+ (CGFloat) estimatedHeight {
    return [self estimatedHeightWithItem:nil];
}

+ (CGFloat) estimatedHeightWithItem:(id)item {
    return [[self itemViewClass] estimatedHeightWithItem:item];
}

@end
