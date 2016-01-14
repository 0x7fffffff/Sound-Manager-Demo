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
#import "PlayerTableViewCell.h"
#import "VersionChecks.h"

@interface PlayerViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end


@implementation PlayerViewController

#pragma MARK - Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 60.0;
    
    [[SoundManager sharedManager] loadDefaultSoundsReplaceExisting:NO];
    
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

- (BOOL)respondsToSelector:(SEL)aSelector
{
    static BOOL shouldRespond;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shouldRespond = SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0");
    });

    if (aSelector == @selector(tableView:editActionsForRowAtIndexPath:)) {
        return shouldRespond;
    }
    
    return [super respondsToSelector:aSelector];
}

- (void)contentSizeCategoryDidChangeNotification:(NSNotification *)notification
{
    NSLog(@"content size changed");
    [self.tableView reloadRowsAtIndexPaths:self.tableView.indexPathsForVisibleRows
                          withRowAnimation:UITableViewRowAnimationNone];
}

#pragma MARK - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [SoundManager sharedManager].availableSounds.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PlayerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PlayerCellIdentifier"
                                                                forIndexPath:indexPath];
    Sound *currentSound = [[SoundManager sharedManager].availableSounds objectAtIndex:indexPath.row];
//    cell.textLabel.text = currentSound.fileName;
    cell.nameLabel.text = currentSound.fileName;
    [cell layoutIfNeeded];
    
    return cell;
}

#pragma MARK - UITableViewDelegate
- (nullable NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SoundManager *manager = [SoundManager sharedManager];
    Sound *nextSound = [manager soundAtIndex:indexPath.row];
    __weak UITableView *wTableView = tableView;
    
    UITableViewRowAction *playNextAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal
                                                                              title:@"Next"
                                                                            handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
                                                                                [manager playSound:nextSound beginImmediately:NO];
                                                                                [wTableView setEditing:NO animated:YES];
                                                                            }];
    
    UITableViewRowAction *playLastAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal
                                                                              title:@"Last"
                                                                            handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
                                                                                [manager enqueueSound:nextSound];
                                                                                [wTableView setEditing:NO animated:YES];
                                                                            }];
    playNextAction.backgroundColor = self.view.tintColor;
    playLastAction.backgroundColor = self.view.tintColor;
    
    return @[playNextAction, playLastAction];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SoundManager *manager = [SoundManager sharedManager];
    Sound *soundToPlay = [manager soundAtIndex:indexPath.row];
    [manager playSound:soundToPlay beginImmediately:YES];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
