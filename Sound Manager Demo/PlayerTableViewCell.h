//
//  PlayerTableViewCell.h
//  Sound Manager Demo
//
//  Created by Michael MacCallum on 1/13/16.
//  Copyright © 2016 Michael MacCallum. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayerTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *queuePositionLabel;

@end
