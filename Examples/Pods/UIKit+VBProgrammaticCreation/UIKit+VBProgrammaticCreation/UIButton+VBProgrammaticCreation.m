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

#import "UIButton+VBProgrammaticCreation.h"

#import <VBException/VBInvalidClassException.h>
#import <UIButton+BackgroundColor/UIButton+BackgroundColor.h>

@implementation UIButton (VBProgrammaticCreation)

+ (instancetype) buttonWithTitle:(id) titleForState
                      titleColor:(id) titleColorForState
                       titleFont:(UIFont*) titleFont
                 backgroundColor:(id) backgroundColorForState
                          target:(id)target
                          action:(SEL)action {
    return [self buttonWithImage:nil
                           title:titleForState
                      titleColor:titleColorForState
                       titleFont:titleFont
                 backgroundColor:backgroundColorForState
                          target:target
                          action:action];
}

+ (instancetype) buttonWithImage:(id) imageForState
                          target:(id)target
                          action:(SEL)action {
    return [self buttonWithImage:imageForState
                           title:nil
                      titleColor:nil
                       titleFont:nil
                 backgroundColor:nil
                          target:target
                          action:action];
}

+ (instancetype) buttonWithImage:(id) imageForState
                           title:(id) titleForState
                      titleColor:(id) titleColorForState
                       titleFont:(UIFont*) titleFont
                 backgroundColor:(id) backgroundColorForState
                          target:(id)target
                          action:(SEL)action {
    
    UIButton* bn = [self buttonWithType:UIButtonTypeCustom];
    
    NSDictionary* dictState = nil;
    //
    if (imageForState) {
        dictState = [self dictionaryFromValue:imageForState
                               withValueClass:[UIImage class]];
        for (NSNumber* state in dictState.allKeys) {
            [bn setImage:dictState[state]
                forState:state.integerValue];
        }
    }
    
    //
    if (backgroundColorForState) {
        dictState = [self dictionaryFromValue:backgroundColorForState
                               withValueClass:[UIColor class]];
        for (NSNumber* state in dictState.allKeys) {
            [bn setBackgroundColor:dictState[state]
                          forState:state.integerValue];
        }
    }
    
    //
    if (titleForState) {
        dictState = [self dictionaryFromValue:titleForState
                               withValueClass:[NSString class]];
        for (NSNumber* state in dictState.allKeys) {
            [bn setTitle:dictState[state]
                forState:state.integerValue];
        }
    }
    
    //
    if (titleColorForState) {
        dictState = [self dictionaryFromValue:titleColorForState
                               withValueClass:[UIColor class]];
        for (NSNumber* state in dictState.allKeys) {
            [bn setTitleColor:dictState[state]
                     forState:state.integerValue];
        }
    }
    
    //
    if (titleFont) {
        bn.titleLabel.font = titleFont;
    }
    
    //
    if (target && action) {
        [bn addTarget:target
               action:action
     forControlEvents:UIControlEventTouchUpInside];
    }
    
    //
    [bn sizeToFit];
    CGRect frame = bn.frame;
    if (frame.size.height < 44) {
        frame.size.height = 44;
    }
    if (frame.size.width < 44) {
        frame.size.width = 44;
    }
    bn.frame = frame;
    
    return bn;
}

+ (NSDictionary*) dictionaryFromValue:(id)value
                       withValueClass:(Class)valueClass {
    NSDictionary* dictState = value;
    if ([value isKindOfClass:valueClass]) {
        dictState = @{@(UIControlStateNormal):   value};
        
    }else if ([value isKindOfClass:[NSDictionary class]]) {
        dictState = value;

    }else{
        @throw [VBInvalidClassException exceptionWithUserInfo:@{@"expected":    @"NSDictionary",
                                                                @"given":       NSStringFromClass([value class])}];
    }
    
    return dictState;
}

@end
