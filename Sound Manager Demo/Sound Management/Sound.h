//
//  Sound.h
//  Sound Manager Demo
//
//  Created by Michael MacCallum on 1/13/16.
//  Copyright © 2016 Michael MacCallum. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  Represents a sound meant to be consumed by SoundManager. This class doesn't
 *  store the underlying data of the sound, only a url to its location on disk
 *  and therefore requires the sound file specified upon instantiation to
 *  remaing at the same file path.
 */
@interface Sound : NSObject

@property (strong, nonatomic, readonly) NSURL * _Nonnull filePath;
@property (strong, nonatomic, readonly) NSString * _Nullable fileName;
@property (strong, nonatomic, readonly) NSString * _Nullable fileExtension;

- (_Nonnull instancetype)initWithUrl:(NSURL * _Nonnull)filePath;

@end
