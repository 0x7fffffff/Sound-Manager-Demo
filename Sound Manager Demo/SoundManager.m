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

@property (strong, nonatomic) NSMutableArray<Sound *> * _Nonnull queue;
@property (strong, nonatomic) AVAudioPlayer * _Nullable player;

@end

@implementation SoundManager
@synthesize availableSounds = _availableSounds;

+ (_Nonnull instancetype)sharedManager
{
    static SoundManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[SoundManager alloc] init];
    });
    
    return manager;
}

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
    
    NSMutableArray *sounds = [[NSMutableArray alloc] initWithCapacity:files.count];
    for (NSURL *fileUrl in files) {
        [sounds addObject:[[Sound alloc] initWithUrl:fileUrl]];
    }

    if (replace) {
        [self.availableSounds removeAllObjects];
    }
    
    [self.availableSounds addObjectsFromArray:sounds];
}

- (Sound * _Nullable)soundAtIndex:(NSInteger)index
{
    if (index >= self.availableSounds.count) {
        return nil;
    }
    
    return [self.availableSounds objectAtIndex:index];
}

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
        
    }
    
    self.player.delegate = self;
    [self.player play];
}

- (void)playSound:(Sound * _Nonnull)sound beginImmediately:(BOOL)immediate
{
}

- (void)enqueueSound:(Sound * _Nonnull)sound
{
    if (self.player && self.player.playing) {
        [self.queue addObject:sound];
    } else {
        [self playSound:sound];
    }
}

#pragma MARK - AVAudioPlayerDelegate

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    NSLog(@"Done playing sound");
    Sound *nextSound = self.queue.firstObject;
    if (nextSound) {
        [self.queue removeObjectAtIndex:0];
        [self playSound:nextSound];
    }
}

- (void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)player error:(NSError *)error
{
    
}

- (void)audioPlayerBeginInterruption:(AVAudioPlayer *)player
{
    
}

- (void)audioPlayerEndInterruption:(AVAudioPlayer *)player withOptions:(NSUInteger)flags
{
    
}

@end
