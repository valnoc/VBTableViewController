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

@interface UIView (VBAutolayout)

#pragma mark - addSubview
/**
 *  Add subview with translatesAutoresizingMaskIntoConstraints = NO
 *
 *  @param view subview
 */
- (void) addSubviewAutolayoutReady:(nonnull UIView *)view;

/**
 *  Add subview with constraints from layout dictionary.
 *  <br>For layout format visit NSLayoutConstraint+VBAutolayout.h
 *  @see +constraintsWithItem:layout:
 *
 *  @param view subview
 *  @param layout Constraints described in VBAutolayout format.
 *
 *  @return Created constraints as NSDictionary. Keys are VBAutolayoutAttribute-s. Values are NSLayoutConstraint* or NSArray<NSLayoutConstraint*>* depending on given layout.
 */
- (nonnull NSDictionary*) addSubview:(nonnull UIView *)view
                          withLayout:(nonnull NSDictionary*)layout;

#pragma mark - constraints
/**
 *  Add constraint and call setNeedsLayout, layoutIfNeeded
 *
 *  @param constraint Constraint to add
 *
 *  @return returns added constraint
 */
- (nonnull NSLayoutConstraint*) addConstraintAndLayoutSubviews:(nonnull NSLayoutConstraint*) constraint;

/**
 *  Add constraint and call setNeedsLayout, layoutIfNeeded
 *
 *  @param constraints Constraints to add
 *
 *  @return added constraints
 */
- (nonnull NSArray<NSLayoutConstraint*>*) addConstraintsAndLayoutSubviews:(nonnull NSArray<NSLayoutConstraint*>*)constraints;

@end
