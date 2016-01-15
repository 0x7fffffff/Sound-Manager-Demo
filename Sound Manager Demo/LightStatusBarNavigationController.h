//
//  LightStatusBarNavigationController.h
//  Sound Manager Demo
//
//  Created by Michael MacCallum on 1/14/16.
//  Copyright © 2016 Michael MacCallum. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  A subclass of UINavigationController that only exists to override
 *  <code>-preferredStatusBarStyle</code> and force a white status bar.
 */
@interface LightStatusBarNavigationController : UINavigationController

@end
