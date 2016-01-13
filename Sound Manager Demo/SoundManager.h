//
//  SoundManager.h
//  Sound Manager Demo
//
//  Created by Michael MacCallum on 1/13/16.
//  Copyright © 2016 Michael MacCallum. All rights reserved.
//

@import Foundation;
@class Sound;

/**
 *  SoundManager is a class that facilitates the playing of sounds. It allows you to play a 
 *  <code>Sound</code> object either immediately, or by enqueuing it. You should only ever attempt to
 *  access an instance of this class through its singleton reference <code>-sharedManager</code>.
 */
@interface SoundManager : NSObject

@property (strong, nonatomic, readonly) NSMutableArray<Sound *> * _Nonnull availableSounds;

/**
 *  A singleton reference to the <code>SoundManager</code> class. Not thread safe.
 */
+ (_Nonnull instancetype)sharedManager;
-(_Nonnull instancetype) init __attribute__((unavailable("Please use the sharedManager singleton instead.")));

/**
 *  Plays the specified sound
 *
 *  @param sound     The Sound to be played.
 *  @param immediate Specifies whether or not the sound should start playing immediately.
 *         If YES, any currently playing sound will be stopped to play the new one. If NO,
 *         the specified sound will be pushed to the from of the queue, and will be the next
 *         sound to play after the current one finishes.
 */
- (void)playSound:(Sound * _Nonnull)sound beginImmediately:(BOOL)immediate;

/**
 *  Plays the specified sound after all other sounds in the queue have finished playing.
 *
 *  @param sound The Sound to be played.
 */
- (void)enqueueSound:(Sound * _Nonnull)sound;

/**
 *  Returns whether or not the manager's underlying player is currently playing a sound.
 */
@property (nonatomic, assign, getter=isPlaying) BOOL playing;

/**
 *  Resumes playback if the underlying player is paused. Otherwise, does nothing.
 *
 *  @return YES if successful, NO otherwise.
 */
- (BOOL)resume;

/**
 *  Pauses playback if the underlying playing is playing. Otherwise, does nothing.
 *
 *  @return YES if successful, NO otherwise.
 */
- (void)pause;

/**
 *  Skips ahead to the next Sound in the queue. If the queue is empty, this does nothing.
 */
- (void)skip;

/**
 *  If the underlying player is currently playing, stops it. Otherwise, does nothing.
 */
- (void)stop;

/**
 *  Looks up the Sound at the specified index in the <code>availableSounds</code> array.
 */
- (Sound * _Nullable)soundAtIndex:(NSInteger)index;

/**
 *  If a "Sounds" folder exists in the main bundle, load any sound files within it into
 *  the <code>availableSounds</code> array.
 *
 *  @param replace If YES, all sounds in <code>availableSounds</code> will be removed before adding
 *         the defaults. If NO, the default sounds will be added to the end of the 
 *         <code>availableSounds</code> array.
 */
- (void)loadDefaultSoundsReplaceExisting:(BOOL)replace;

@end
