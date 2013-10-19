//
//  OutputDataViewCell.h
//  UroApp
//
//  Created by Jeremy Wiygul on 10/29/12.
//  Copyright (c) 2012 Jeremy Wiygul. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OutputDataViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextField *timeField;
@property (weak, nonatomic) IBOutlet UITextField *typeField;
@property (weak, nonatomic) IBOutlet UITextField *qualityField;
- (IBAction)timePickerButton:(id)sender;
- (IBAction)typePickerButton:(id)sender;
- (IBAction)qualityPickerButton:(id)sender;
@property (weak, nonatomic) UITableView *tableView;
@property (weak, nonatomic)id controller;
@property (weak, nonatomic) IBOutlet UIImageView *randomImage;
@end
