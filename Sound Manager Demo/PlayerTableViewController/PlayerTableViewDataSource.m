//
//  PlayerTableViewDataSource.m
//  Sound Manager Demo
//
//  Created by Michael MacCallum on 1/13/16.
//  Copyright © 2016 Michael MacCallum. All rights reserved.
//

#import "PlayerTableViewDataSource.h"
#import "Sound.h"
#import "SoundManager.h"

@implementation PlayerTableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [SoundManager sharedManager].availableSounds.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PlayerCellIdentifier"
                                                                forIndexPath:indexPath];
    SoundManager *soundManager = [SoundManager sharedManager];
    Sound *currentSound = [soundManager.availableSounds objectAtIndex:indexPath.row];

    cell.textLabel.text = currentSound.fileName;
    cell.detailTextLabel.text = currentSound.fileExtension;
    
    return cell;
}

@end
