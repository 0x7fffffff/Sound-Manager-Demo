//
//  UIColor+UIColor_Darken.h
//  Sound Manager Demo
//
//  Created by Michael MacCallum on 1/14/16.
//  Copyright © 2016 Michael MacCallum. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Darken)

/**
 *  Darkens the receiver by a given percentage by descreasing its brightness.
 *
 *  @param percentage The percentage to darken the receiver by. [0.0, 1.0]
 */
- (UIColor *)darkenedBy:(CGFloat)percentage;

@end
