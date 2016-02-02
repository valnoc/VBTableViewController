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

#import "NSLayoutConstraint+VBAutolayout.h"

@implementation NSLayoutConstraint (VBAutolayout)

#pragma mark - short
+ (nonnull instancetype) constraintWithItem:(nonnull id)view1
                                  attribute:(NSLayoutAttribute)attr1
                                  relatedBy:(NSLayoutRelation)relation
                                     toItem:(nonnull id)view2
                                  attribute:(NSLayoutAttribute)attr2 {
    return [NSLayoutConstraint constraintWithItem:view1
                                        attribute:attr1
                                        relatedBy:relation
                                           toItem:view2
                                        attribute:attr2
                                       multiplier:[self defaultMultiplier]
                                         constant:[self defaultConstant]];
}

+ (nonnull instancetype) constraintWithItem:(nonnull id)view1
                                  attribute:(NSLayoutAttribute)attr1
                                  relatedBy:(NSLayoutRelation)relation
                                     toItem:(nonnull id)view2
                                  attribute:(NSLayoutAttribute)attr2
                                   constant:(CGFloat)c {
    return [NSLayoutConstraint constraintWithItem:view1
                                        attribute:attr1
                                        relatedBy:relation
                                           toItem:view2
                                        attribute:attr2
                                       multiplier:[self defaultMultiplier]
                                         constant:c];
}

+ (nonnull instancetype) constraintWithItem:(nonnull id)view1
                                  attribute:(NSLayoutAttribute)attr1
                                  relatedBy:(NSLayoutRelation)relation
                                     toItem:(nonnull id)view2
                                  attribute:(NSLayoutAttribute)attr2
                                 multiplier:(CGFloat)multiplier {
    return [NSLayoutConstraint constraintWithItem:view1
                                        attribute:attr1
                                        relatedBy:relation
                                           toItem:view2
                                        attribute:attr2
                                       multiplier:multiplier
                                         constant:[self defaultConstant]];
}

+ (double) defaultMultiplier {
    return 1.0f;
}

+ (double) defaultConstant {
    return 0.0f;
}

#pragma mark - layout
+ (nonnull NSDictionary*) constraintsWithItem:(nonnull id) view1
                                       layout:(nonnull NSDictionary*) layout {
    NSMutableDictionary* cnstr = [NSMutableDictionary new];
    
    [self addConstraintsToDictionary:cnstr
                            withItem:view1
                          attribute1:NSLayoutAttributeTop
                          attribute2:NSLayoutAttributeBottom
                                attr:VBAutolayoutAttributeTop
                              layout:layout];

    [self addConstraintsToDictionary:cnstr
                            withItem:view1
                          attribute1:NSLayoutAttributeBottom
                          attribute2:NSLayoutAttributeTop
                                attr:VBAutolayoutAttributeBottom
                              layout:layout];
    
    [self addConstraintsToDictionary:cnstr
                            withItem:view1
                          attribute1:NSLayoutAttributeLeading
                          attribute2:NSLayoutAttributeTrailing
                                attr:VBAutolayoutAttributeLeading
                              layout:layout];
    
    [self addConstraintsToDictionary:cnstr
                            withItem:view1
                          attribute1:NSLayoutAttributeTrailing
                          attribute2:NSLayoutAttributeLeading
                                attr:VBAutolayoutAttributeTrailing
                              layout:layout];
    
    [self addConstraintsToDictionary:cnstr
                            withItem:view1
                          attribute1:NSLayoutAttributeWidth
                          attribute2:NSLayoutAttributeNotAnAttribute
                                attr:VBAutolayoutAttributeWidth
                              layout:layout];
    
    [self addConstraintsToDictionary:cnstr
                            withItem:view1
                          attribute1:NSLayoutAttributeHeight
                          attribute2:NSLayoutAttributeNotAnAttribute
                                attr:VBAutolayoutAttributeHeight
                              layout:layout];
    
    [self addConstraintsToDictionary:cnstr
                            withItem:view1
                          attribute1:NSLayoutAttributeCenterX
                          attribute2:NSLayoutAttributeCenterX
                                attr:VBAutolayoutAttributeCenterX
                              layout:layout];
    
    [self addConstraintsToDictionary:cnstr
                            withItem:view1
                          attribute1:NSLayoutAttributeCenterY
                          attribute2:NSLayoutAttributeCenterY
                                attr:VBAutolayoutAttributeCenterY
                              layout:layout];

    return cnstr;
}

#pragma mark helpers
+ (void) addConstraintsToDictionary:(NSMutableDictionary*)cnstr
                           withItem:(id) view1
                         attribute1:(NSLayoutAttribute)attr1
                         attribute2:(NSLayoutAttribute)attr2
                               attr:(NSString*)attr
                             layout:(id)layout {
    if (layout[attr]) {
        NSArray* constraints = [self constraintsWithItem:view1
                                              attribute1:attr1
                                              attribute2:attr2
                                                attrInfo:layout[attr]];
        cnstr[attr] = constraints.count > 1 ? constraints : constraints.lastObject;
    }
}

+ (nonnull NSArray<NSLayoutConstraint*>*) constraintsWithItem:(nonnull id) view1
                                                   attribute1:(NSLayoutAttribute)attr1
                                                   attribute2:(NSLayoutAttribute)attr2
                                                     attrInfo:(id)attrInfo {
    NSMutableArray<NSLayoutConstraint*>* result = [NSMutableArray new];
    if ([attrInfo isKindOfClass:[NSString class]]) {
        attrInfo = @{VBAutolayoutConstant: attrInfo};
    }
    if ([attrInfo isKindOfClass:[NSDictionary class]]) {
        [result addObject:[self constraintWithItem:view1
                                        attribute1:attr1
                                        attribute2:attr2
                                         attrInfo:attrInfo]];
    }else{
        for (NSDictionary* info in attrInfo) {
            [result addObject:[self constraintWithItem:view1
                                            attribute1:attr1
                                            attribute2:attr2
                                              attrInfo:info]];
        }
    }
    return result;
}

+ (nonnull instancetype) constraintWithItem:(nonnull id) view1
                                 attribute1:(NSLayoutAttribute)attr1
                                 attribute2:(NSLayoutAttribute)attr2
                                   attrInfo:(NSDictionary*)attrInfo {
    UIView* superview = ((UIView*)view1).superview;
    NSArray<NSNumber*>* cnstInfo = [self parsedLayoutConstant:attrInfo[VBAutolayoutConstant]];
    //
    id item = attrInfo[VBAutolayoutItem];
    NSLayoutRelation relation = [cnstInfo[0] integerValue];
    double constant = [cnstInfo[1] doubleValue];
    double priority = [cnstInfo[2] doubleValue];
    //
    if (attr2 == NSLayoutAttributeNotAnAttribute) {
        item = nil;
    }else if (item == nil) {
        item = superview;
        attr2 = attr1;
        if (attr1 == NSLayoutAttributeTrailing || attr1 == NSLayoutAttributeBottom) {
            constant = -constant;
        }
    }
    //
    NSLayoutConstraint* cnstr = [NSLayoutConstraint constraintWithItem:view1
                                                             attribute:attr1
                                                             relatedBy:relation
                                                                toItem:item
                                                             attribute:attr2
                                                              constant:constant];
    cnstr.priority = priority;
    return cnstr;
}

+ (nonnull NSArray<NSNumber*>*) parsedLayoutConstant:(NSString*) constant {
    NSArray<NSString*>* comp = [[constant stringByReplacingOccurrencesOfString:@"([><=]*)\\(?(-?\\d*)\\)?@?(\\d*)"
                                                        withString:@"$1,$2,$3"
                                                           options:NSRegularExpressionSearch
                                                             range:NSMakeRange(0, constant.length)]
                                componentsSeparatedByString:@","];
    
    NSLayoutRelation relation = NSLayoutRelationEqual;
    if ([constant hasPrefix:@">"]) {
        relation = NSLayoutRelationGreaterThanOrEqual;
    }else if ([constant hasPrefix:@"<"]) {
        relation = NSLayoutRelationLessThanOrEqual;
    }
    
    NSInteger value = comp[1].length > 0 ? comp[1].integerValue : 0;
    NSInteger priority = comp[2].length > 0 ? comp[2].integerValue : 1000;
    return @[@(relation), @(value), @(priority)];
}

@end