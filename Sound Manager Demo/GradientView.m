//
//  GradientView.m
//  Sound Manager Demo
//
//  Created by Michael MacCallum on 1/13/16.
//  Copyright © 2016 Michael MacCallum. All rights reserved.
//

#import "GradientView.h"

@implementation GradientView

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    CAGradientLayer *gradientLayer = (CAGradientLayer *)self.layer;
    
    UIColor *topColor = [UIColor colorWithRed:32.0 / 255.0
                                        green:5.0 / 255.0
                                         blue:58.0 / 255.0
                                        alpha:1.0];
    
    UIColor *bottomColor = [UIColor colorWithRed:26.0 / 255.0
                                           green:5.0 / 255.0
                                            blue:62.0 / 255.0
                                           alpha:1.0];
    
    gradientLayer.colors = @[(id)topColor.CGColor, (id)bottomColor.CGColor];
    gradientLayer.locations = @[@0.0, @1.0];
}

+ (Class)layerClass
{
    return [CAGradientLayer class];
}

@end
