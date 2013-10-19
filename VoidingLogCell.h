//
//  VoidingLogCell.h
//  UroApp
//
//  Created by Jeremy Wiygul on 10/29/12.
//  Copyright (c) 2012 Jeremy Wiygul. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VoidingLogCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *whatLabel;
@property (weak, nonatomic) IBOutlet UILabel *amountLabel;
@property (weak, nonatomic) IBOutlet UIImageView *infoImage;
- (IBAction)seeInfoBehindImage:(id)sender;
@property (weak,nonatomic) id controller;
@property (weak,nonatomic) UITableView *tableView;

-(void)setCharacter:(UIImage *)image withInfoType:(NSString *)infoType;

@end
