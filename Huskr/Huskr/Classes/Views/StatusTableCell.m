//
//  StatusTableCell.m
//  Huskr
//
//  Created by Jared Egan on 10/3/12.
//  Copyright 2012 Jared Egan. All rights reserved.
//

#import "StatusTableCell.h"
#import "Status.h"

////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
@interface StatusTableCell()

@property (nonatomic, strong) UILabel *usernameLabel;
@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UILabel *statusLabel;

@end

////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation StatusTableCell

#pragma mark -
#pragma mark Init & Factory
////////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if (self) {
        self.usernameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 300, 30)];
        self.usernameLabel.font = [UIFont boldSystemFontOfSize:16.0];
        
        self.dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(10,
                                                                   self.usernameLabel.frame.origin.y + self.usernameLabel.frame.size.height,
                                                                   300,
                                                                   30)];
        self.dateLabel.font = [UIFont systemFontOfSize:14.0];
        
        self.statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(10,
                                                                     self.dateLabel.frame.origin.y + self.dateLabel.frame.size.height,
                                                                     300,
                                                                     70)];
        self.statusLabel.font = [UIFont systemFontOfSize:14.0];
        self.statusLabel.numberOfLines = 0;
        
        [self.contentView addSubview:self.usernameLabel];
        [self.contentView addSubview:self.dateLabel];
        [self.contentView addSubview:self.statusLabel];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        //self.contentView.backgroundColor = [UIColor greenColor]; // Useful for debugging frames.
	}
	
	return self;
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)dealloc {
	
}

#pragma mark -
#pragma mark StatusTableCell
////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setUpWithStatus:(Status *)status {
    self.usernameLabel.text = status.username;
    self.statusLabel.text = status.title;

    self.dateLabel.text = nil; // TODO
}

@end
