//
//  DataViewCell.h
//  UroApp
//
//  Created by Jeremy Wiygul on 10/29/12.
//  Copyright (c) 2012 Jeremy Wiygul. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextField *timeText;
@property (weak, nonatomic) IBOutlet UITextField *typeText;
@property (weak, nonatomic) IBOutlet UITextField *whatText;
@property (weak, nonatomic) IBOutlet UITextField *amountText;
- (IBAction)showTimePicker:(id)sender;
- (IBAction)showTypeIntakePicker:(id)sender;
- (IBAction)showWhatIntakePicker:(id)sender;
- (IBAction)showAmountIntakePicker:(id)sender;
@property (weak, nonatomic) UITableView *tableView;
@property (weak, nonatomic)id controller;
@property (weak, nonatomic) IBOutlet UIImageView *randomImage;
@end
