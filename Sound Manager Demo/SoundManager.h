//
//  SoundManager.h
//  Sound Manager Demo
//
//  Created by Michael MacCallum on 1/13/16.
//  Copyright © 2016 Michael MacCallum. All rights reserved.
//

@import Foundation;
@class Sound;

@interface SoundManager : NSObject

@property (strong, nonatomic, readonly) NSMutableArray<Sound *> * _Nonnull availableSounds;

+ (_Nonnull instancetype)sharedManager;

- (void)playSound:(Sound * _Nonnull)sound beginImmediately:(BOOL)immediate;

- (Sound * _Nullable)soundAtIndex:(NSInteger)index;
- (void)loadDefaultSoundsReplaceExisting:(BOOL)replace;

@end
