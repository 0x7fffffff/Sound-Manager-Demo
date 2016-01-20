//
//  ViewController.m
//  Sound Manager Demo
//
//  Created by Michael MacCallum on 1/13/16.
//  Copyright © 2016 Michael MacCallum. All rights reserved.
//

#import "PlayerViewController.h"
#import "SoundManager.h"
#import "Sound.h"
#import "VersionChecks.h"

/**
 *  The context used for KVO events on <code>-[SoundManager currentlyPlayingSound]</code>
 */
static void *currentlyPlayingSoundContext = &currentlyPlayingSoundContext;

@interface PlayerViewController ()

@property (weak, nonatomic, null_unspecified) IBOutlet UITableView *tableView;

@end


@implementation PlayerViewController

#pragma mark - Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    SoundManager *manager = [SoundManager sharedManager];
    
    [manager addObserver:self
              forKeyPath:NSStringFromSelector(@selector(currentlyPlayingSound))
                 options:NSKeyValueObservingOptionNew
                 context:currentlyPlayingSoundContext];
}

- (void)dealloc
{
    SoundManager *manager = [SoundManager sharedManager];

    @try {
        [manager removeObserver:self
                     forKeyPath:NSStringFromSelector(@selector(currentlyPlayingSound))
                        context:currentlyPlayingSoundContext];
    } @catch (NSException *exception) {
        // Just in case. Nothing to see here folks.
    }
}

#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSString *,id> *)change
                       context:(void *)context
{
    if (context == currentlyPlayingSoundContext) {
        [self selectNowPlayingIndexPath];
    } else {
        [super observeValueForKeyPath:keyPath
                             ofObject:object
                               change:change
                              context:context];
    }
}

- (void)selectNowPlayingIndexPath
{
    SoundManager *manager = [SoundManager sharedManager];
    Sound *currentSound = manager.currentlyPlayingSound;
    
    if (currentSound) {
        self.navigationItem.prompt = [NSString stringWithFormat:@"%@.%@", currentSound.fileName, currentSound.fileExtension];

        NSInteger index = [manager availabilityPositionOfSound:currentSound];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:self.tableView.numberOfSections - 1];
        
        [self.tableView selectRowAtIndexPath:indexPath
                                    animated:YES
                              scrollPosition:UITableViewScrollPositionNone];
    } else {
        self.navigationItem.prompt = nil;
        if (self.tableView.indexPathForSelectedRow) {
            [self.tableView deselectRowAtIndexPath:self.tableView.indexPathForSelectedRow
                                          animated:YES];
        }
    }
}

@end
