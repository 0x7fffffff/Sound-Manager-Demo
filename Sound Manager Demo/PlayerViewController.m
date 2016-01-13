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

@interface PlayerViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end


@implementation PlayerViewController

#pragma MARK - Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];

    [[SoundManager sharedManager] loadDefaultSoundsReplaceExisting:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    cell.textLabel.text = currentSound.fileName;
    
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
    [playNextAction setBackgroundColor:[UIColor blueColor]];
    [playLastAction setBackgroundColor:[UIColor greenColor]];
    return @[playNextAction, playLastAction];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SoundManager *manager = [SoundManager sharedManager];
    Sound *soundToPlay = [manager soundAtIndex:indexPath.row];
    [manager playSound:soundToPlay beginImmediately:YES];
}

@end
