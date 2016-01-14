//
//  PlayerTableViewDataSource.m
//  Sound Manager Demo
//
//  Created by Michael MacCallum on 1/13/16.
//  Copyright © 2016 Michael MacCallum. All rights reserved.
//

#import "PlayerTableViewDataSource.h"
#import "PlayerTableViewCell.h"
#import "Sound.h"
#import "SoundManager.h"

@implementation PlayerTableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"%lu", [SoundManager sharedManager].availableSounds.count);
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

@end
