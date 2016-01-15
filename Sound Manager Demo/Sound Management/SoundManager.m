//
//  SoundManager.m
//  Sound Manager Demo
//
//  Created by Michael MacCallum on 1/13/16.
//  Copyright © 2016 Michael MacCallum. All rights reserved.
//

@import AVFoundation;
#import "SoundManager.h"
#import "Sound.h"


@interface SoundManager () <AVAudioPlayerDelegate>


// Documented publicly
@property (strong, nonatomic, readwrite, nullable) Sound *currentlyPlayingSound;

/**
 *  A queue of Sounds that will be automatically played as the previous sounds finish.
 */
@property (strong, nonatomic, nonnull) NSMutableArray<Sound *> *queue;

/**
 *  The underlying AVAudioPlayer responsible for playing sound files specified by the
 *  filePath of Sound objects.
 */
@property (strong, nonatomic, nullable) AVAudioPlayer *player;

@end

@implementation SoundManager
@synthesize availableSounds = _availableSounds;


#pragma MARK - Lifecycle

// Documented publicly
+ (_Nonnull instancetype)sharedManager
{
    static SoundManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[SoundManager alloc] _init];
    });
    
    return manager;
}

/**
 *  A private initializer which only exists in this form because <code>-init</code> has been marked
 *  as unavailable to prevent this class from being directly instantiate by the outside world.
 *
 *  @return An instance of SoundManager
 */
- (_Nonnull instancetype)_init
{
    return self = [super init];
}

+ (BOOL)automaticallyNotifiesObserversOfCurrentlyPlayingSound
{
    return YES;
}

// Documented publicly
- (BOOL)isPlaying
{
    return self.player.isPlaying;
}

// Documented publicly
- (NSMutableArray<Sound *> * _Nonnull)availableSounds
{
    if (_availableSounds == nil) {
        _availableSounds = [[NSMutableArray<Sound *> alloc] init];
    }
    
    return _availableSounds;
}

- (NSMutableArray<Sound *> * _Nonnull)queue
{
    if (_queue == nil) {
        _queue = [[NSMutableArray<Sound *> alloc] init];
    }
    
    return _queue;
}

// Documented publicly
- (void)loadDefaultSoundsReplaceExisting:(BOOL)replace
{
    NSFileManager *manager = [NSFileManager defaultManager];
    NSURL *fileUrl = [[NSBundle mainBundle] URLForResource:@"Sounds"
                                             withExtension:nil];
    
    NSError *fileError = nil;
    NSArray *files = [manager contentsOfDirectoryAtURL:fileUrl
                            includingPropertiesForKeys:@[]
                                               options:NSDirectoryEnumerationSkipsHiddenFiles
                                                 error:&fileError];
    if (fileError) {
        NSLog(@"%@", fileError.localizedDescription);
        return;
    }
    
    // Assuming the demo file types are the only ones we'll encounter. Not exhaustive.
    NSArray *supportedFormats = @[@"aif", @"aiff", @"mp3", @"wav"];
    
    // Transform the array of urls into an array of sounds.
    NSMutableArray *sounds = [[NSMutableArray alloc] initWithCapacity:files.count];
    for (NSURL *fileUrl in files) {
        if ([supportedFormats containsObject:fileUrl.pathExtension.lowercaseString]) {
            [sounds addObject:[[Sound alloc] initWithUrl:fileUrl]];
        }
    }

    if (replace) {
        [self.availableSounds removeAllObjects];
    }
    
    [self.availableSounds addObjectsFromArray:sounds];
}

// Documented publicly
- (Sound * _Nullable)soundAtIndex:(NSInteger)index
{
    if (index >= self.availableSounds.count) {
        return nil;
    }
    
    return [self.availableSounds objectAtIndex:index];
}

// Documented publicly
- (NSInteger)queuePositionOfSound:(Sound *)sound
{
    return [self.queue indexOfObject:sound];
}

// Documented publicly
- (NSInteger)availabilityPositionOfSound:(Sound *)sound
{
    return [self.availableSounds indexOfObject:sound];
}

#pragma MARK - Player state

// Documented publicly
- (BOOL)resume
{
    if (self.player && !self.player.playing) {
        return [self.player play];
    }
    
    return NO;
}

// Documented publicly
- (void)pause
{
    if (self.player) {
        [self.player pause];
    }
}

// Documented publicly
- (void)skip
{
    [self playNextSound];
}

// Documented publicly
- (void)stop
{
    if (self.player) {
        [self.player stop];
    }
}

/**
 *  Calls <code>-playSound:</code> with the next available sound in the queue, if one exists.
 */
- (void)playNextSound
{
    Sound *nextSound = self.queue.firstObject;
    if (nextSound) {
        [self.queue removeObjectAtIndex:0];
        [self playSound:nextSound];
    } else {
        self.currentlyPlayingSound = nil;
    }
}

/**
 *  Plays the specified sound immediately. If there are any other sounds playing when
 *  this method is called, they will be cancelled immediately and the new sounds will
 *  start playing.
 */
- (void)playSound:(Sound * _Nonnull)sound
{
    if (self.player) {
        [self.player stop];
        self.player = nil;
    }
    
    NSError *audioFileError = nil;
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:sound.filePath
                                                         error:&audioFileError];
    if (audioFileError) {
        NSLog(@"%@", audioFileError.localizedDescription);
       self.currentlyPlayingSound = nil;
    } else {
        if ([self.player play]) {
            self.player.delegate = self;
            self.currentlyPlayingSound = sound;
        } else {
            self.currentlyPlayingSound = nil;
        }
    }
}

// Documented publicly
- (void)playSound:(Sound * _Nonnull)sound beginImmediately:(BOOL)immediate
{
    if (immediate) {
        [self playSound:sound];
    } else {
        if (self.queue.count == 0) {
            if (self.player && self.player.playing) {
                [self.queue insertObject:sound atIndex:0];
            } else {
                [self playSound:sound];
            }
        } else {
            [self.queue insertObject:sound atIndex:0];
        }
    }
}

// Documented publicly
- (void)enqueueSound:(Sound * _Nonnull)sound
{
    if (self.player && self.player.playing) {
        [self.queue addObject:sound];
    } else {
        [self playSound:sound];
    }
}

#pragma MARK - AVAudioPlayerDelegate

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player
                       successfully:(BOOL)flag
{
    // Regardless of the success of the last sound, attempt to play the next one.
    [self playNextSound];
}

@end
