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

@interface UIButton (VBProgrammaticCreation)

/**
 *  Create button with title.
 *
 *  @param titleForState A dictionary with @(UIControlState) as keys and UIImage's as values. If you give a UIImage instead of dictionary it will be intepreted as @{@(UIControlStateNormal): imageForState}
 *  @param target Target for UIControlEventTouchUpInside
 *  @param action Action forUIControlEventTouchUpInside
 *
 *  @return Created UIButton with sizeToFit and minimun size of (44;44)
 */
+ (instancetype) buttonWithTitle:(id) titleForState
                      titleColor:(id) titleColorForState
                       titleFont:(UIFont*) titleFont
                 backgroundColor:(id) backgroundColorForState
                          target:(id)target
                          action:(SEL)action;

/**
 *  Create button with image.
 *
 *  @param imageForState A dictionary with @(UIControlState) as keys and UIImage's as values. If you give a UIImage instead of dictionary it will be intepreted as @{@(UIControlStateNormal): imageForState}
 *  @param target Target for UIControlEventTouchUpInside
 *  @param action Action forUIControlEventTouchUpInside
 *
 *  @return Created UIButton with sizeToFit and minimun size of (44;44)
 */
+ (instancetype) buttonWithImage:(id) imageForState
                          target:(id)target
                          action:(SEL)action;

@end
