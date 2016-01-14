//
//  PlayerTableViewDelegate.m
//  Sound Manager Demo
//
//  Created by Michael MacCallum on 1/13/16.
//  Copyright © 2016 Michael MacCallum. All rights reserved.
//

#import "PlayerTableViewDelegate.h"
#import "SoundManager.h"
#import "Sound.h"
#import "VersionChecks.h"

@implementation PlayerTableViewDelegate

// Overriden to ensure that -tableView:editActionsForRowAtIndexPath: is only called on
// this object if the iOS version is at least 8.0.
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0")) {
        return UITableViewAutomaticDimension;
    }
    
    return 60.0;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0;
}

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
    playNextAction.backgroundColor = [UIApplication sharedApplication].keyWindow.tintColor;
    playLastAction.backgroundColor = [UIApplication sharedApplication].keyWindow.tintColor;
    
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
