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

#import "UIView+VBAutolayout.h"

#import "NSLayoutConstraint+VBAutolayout.h"

@implementation UIView (VBAutolayout)

#pragma mark - addSubview
- (void) addSubviewAutolayoutReady:(nonnull UIView *)view {
    view.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:view];
}

- (nonnull NSDictionary*) addSubview:(nonnull UIView *)view
                          withLayout:(nonnull NSDictionary*)layout {
    [self addSubviewAutolayoutReady:view];
    
    NSDictionary* dict = [NSLayoutConstraint constraintsWithItem:view
                                                          layout:layout];
    NSMutableArray* cnstr = [NSMutableArray new];
    [dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[NSLayoutConstraint class]]) {
            [cnstr addObject:obj];
        }else{
            [cnstr addObjectsFromArray:obj];
        }
    }];
    [self addConstraintsAndLayoutSubviews:cnstr];

    return dict;
}

#pragma mark - constraints
- (nonnull NSLayoutConstraint*) addConstraintAndLayoutSubviews:(nonnull NSLayoutConstraint*) constraint {
    return [[self addConstraintsAndLayoutSubviews:@[constraint]]
            lastObject];
}
- (nonnull NSArray<NSLayoutConstraint*>*) addConstraintsAndLayoutSubviews:(nonnull NSArray<NSLayoutConstraint*>*)constraints {
    [self addConstraints:constraints];
    [self setNeedsLayout];
    [self layoutIfNeeded];
    
    return constraints;
}

@end
