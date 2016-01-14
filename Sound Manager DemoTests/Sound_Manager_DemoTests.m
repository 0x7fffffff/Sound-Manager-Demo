//
//  Sound_Manager_DemoTests.m
//  Sound Manager DemoTests
//
//  Created by Michael MacCallum on 1/13/16.
//  Copyright © 2016 Michael MacCallum. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SoundManager.h"
#import "Sound.h"

@interface Sound_Manager_DemoTests : XCTestCase

@property(strong, nonatomic) SoundManager *manager;
@property(strong, nonatomic) Sound *sound;

@end

@implementation Sound_Manager_DemoTests

- (void)setUp {
    [super setUp];

    self.manager = [SoundManager sharedManager];
    self.sound = [self.manager soundAtIndex:0];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testLookup
{
    XCTAssertNotNil(self.sound);
}

- (void)testQueuePosition
{
    NSUInteger testExcluded = [self.manager queuePositionOfSound:self.sound];
    XCTAssertEqual(testExcluded, NSNotFound);
    [self.manager enqueueSound:self.sound];
    NSUInteger testIncluded = [self.manager queuePositionOfSound:self.sound];
    XCTAssertNotEqual(testIncluded, NSNotFound);
}

- (void)testLoadDefaultSounds
{
    // -loadDefaultSoundsReplaceExisting: will be called in the root view controller.
    XCTAssertEqual(self.manager.availableSounds.count, 26);
}

- (void)testPlay
{
    [self.manager playSound:self.sound beginImmediately:YES];
    
    XCTAssertTrue(self.manager.isPlaying);
}

- (void)testPauseIfPlaying
{
    if (self.manager.isPlaying) {
        [self.manager pause];
        
        XCTAssertFalse(self.manager.isPlaying);
    }
}

- (void)testPauseIfNotPlaying
{
    if (!self.manager.isPlaying) {
        [self.manager pause];
        
        XCTAssertFalse(self.manager.isPlaying);
    }
}

- (void)testStopIfPlaying
{
    
}

- (void)testStopIfNotPlaying
{
    
}

@end
