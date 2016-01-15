//
//  UIColor+UIColor_Darken.m
//  Sound Manager Demo
//
//  Created by Michael MacCallum on 1/14/16.
//  Copyright © 2016 Michael MacCallum. All rights reserved.
//

#import "UIColor+Darken.h"

@implementation UIColor (Darken)

// Documented publicly
- (UIColor *)darkenedBy:(CGFloat)percentage
{
    CGFloat hue, saturation, brightness, alpha;
    
    BOOL success = [self getHue:&hue
                     saturation:&saturation
                     brightness:&brightness
                          alpha:&alpha];
    if (!success) {
        return self;
    }
    
    return [UIColor colorWithHue:hue
                      saturation:saturation
                      brightness:MIN(MAX(brightness * (1.0 - percentage), 0.0), 1.0)
                           alpha:alpha];
}

@end
