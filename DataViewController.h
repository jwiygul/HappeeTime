//
//  DataViewController.h
//  UroApp
//
//  Created by Jeremy Wiygul on 10/29/12.
//  Copyright (c) 2012 Jeremy Wiygul. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "DataViewCell.h"
#import "LogItem.h"
#import "PickerDataSource.h"
#import "WhatPickerDataSource.h"
#import "AmountPickerDataSource.h"
@class LogItemContainer;
@class FiberAmountPickerDataSource;
@class DrinkTypePickerSource;

@interface DataViewController : UITableViewController

@property (nonatomic,copy)void(^dismissBlock)(void);
@property (nonatomic, retain)UIPickerView *myPickerView;
@property (nonatomic,retain)UIDatePicker *myDatePicker;
@property (nonatomic,strong)LogItem *item;
@property (nonatomic, retain)PickerDataSource *pickerDataSource;
@property (nonatomic, retain)WhatPickerDataSource *whatPickerDataSource;
@property (nonatomic, retain)AmountPickerDataSource *amountPickerDataSource;
@property (nonatomic,retain)FiberAmountPickerDataSource *fiberPickerDataSource;
@property (nonatomic,retain)DrinkTypePickerSource *drinkTypePickerSource;
@property (nonatomic, retain)UIView *pickerGroupView;
@property (nonatomic,retain)UIBarButtonItem *rightBarButton;
@property (nonatomic,retain)UIBarButtonItem *leftBarButton;
@property (nonatomic, retain)UIToolbar *typeToolBar;
@property (nonatomic, retain)UIToolbar *timeToolBar;
@property (nonatomic, retain)UIToolbar *whatToolBar;
@property (nonatomic, retain)UIToolbar *amountToolBar;
@property (nonatomic, retain)UIPickerView *pickerViewInUse;
@property (nonatomic, retain)UIToolbar *toolBarInUse;
@property (nonatomic)BOOL datePickerInUse;

@end
