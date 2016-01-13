//
//  Sound.h
//  Sound Manager Demo
//
//  Created by Michael MacCallum on 1/13/16.
//  Copyright © 2016 Michael MacCallum. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Sound : NSObject

@property (strong, nonatomic, readonly) NSURL * _Nonnull filePath;
@property (strong, nonatomic, readonly) NSString * _Nullable fileName;

- (_Nonnull instancetype)initWithUrl:(NSURL * _Nonnull)filePath;

@end
