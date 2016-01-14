//
//  ViewController.m
//  Sound Manager Demo
//
//  Created by Michael MacCallum on 1/13/16.
//  Copyright © 2016 Michael MacCallum. All rights reserved.
//

#import "PlayerTableViewController.h"
#import "SoundManager.h"
#import "Sound.h"
#import "PlayerTableViewCell.h"
#import "VersionChecks.h"
#import "GradientView.h"

@interface PlayerTableViewController ()

@end


@implementation PlayerTableViewController

#pragma MARK - Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundView = [[GradientView alloc] init];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(contentSizeCategoryDidChangeNotification:)
                                                 name:UIContentSizeCategoryDidChangeNotification
                                               object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIContentSizeCategoryDidChangeNotification
                                                  object:nil];
}

- (void)contentSizeCategoryDidChangeNotification:(NSNotification *)notification
{
    // Force visible cells to reevaluate their layouts to apply the font change.
    [self.tableView reloadRowsAtIndexPaths:self.tableView.indexPathsForVisibleRows
                          withRowAnimation:UITableViewRowAnimationNone];
}

@end
