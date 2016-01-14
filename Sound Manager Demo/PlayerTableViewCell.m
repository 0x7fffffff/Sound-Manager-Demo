//
//  PlayerTableViewCell.m
//  Sound Manager Demo
//
//  Created by Michael MacCallum on 1/13/16.
//  Copyright © 2016 Michael MacCallum. All rights reserved.
//

#import "PlayerTableViewCell.h"

@interface PlayerTableViewCell ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageWidthConstraint;
@property (weak, nonatomic) IBOutlet UIImageView *playingIconImageView;

@end

@implementation PlayerTableViewCell

- (void)awakeFromNib {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {

    // Configure the view for the selected state
}

- (void)layoutIfNeeded
{
    [super layoutIfNeeded];

    self.nameLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
    self.queuePositionLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleSubheadline];
}

@end
