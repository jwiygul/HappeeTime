//
//  OutputLogCell.h
//  UroApp
//
//  Created by Jeremy Wiygul on 10/29/12.
//  Copyright (c) 2012 Jeremy Wiygul. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OutputLogCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *amountLabel;
@property (weak, nonatomic) IBOutlet UIImageView *infoImage;
- (IBAction)seeInfoBehindImage:(id)sender;
-(void)setCharacterWithInfoType:(NSString *)infoType;
@property (nonatomic,strong)id controller;
@property (nonatomic,strong)UITableView *tableView;
@end
