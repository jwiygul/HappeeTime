//
//  OutputDataViewController.h
//  UroApp
//
//  Created by Jeremy Wiygul on 10/29/12.
//  Copyright (c) 2012 Jeremy Wiygul. All rights reserved.
//

#import <Foundation/Foundation.h>

@class OutputTypePickerSource;
@class OutputLogItem;
@class PeeQualityPickerSource;
@class PeeAccidentQualityPickerSource;
@class PoopQualityPickerSource;

@interface OutputDataViewController : UITableViewController
@property (nonatomic,copy)void(^dismissBlock)(void);
@property (nonatomic, retain)UIPickerView *myPickerView;
@property (nonatomic,retain)UIDatePicker *myDatePicker;
@property (nonatomic,strong)OutputLogItem *item;
@property (nonatomic, retain)OutputTypePickerSource *outputTypePickerSource;
@property (nonatomic, retain)UIView *pickerGroupView;
@property (nonatomic,retain)UIBarButtonItem *rightBarButton;
@property (nonatomic,retain)UIBarButtonItem *leftBarButton;
@property (nonatomic,retain)PeeQualityPickerSource *peeQualityPickerSource;
@property (nonatomic,retain)PeeAccidentQualityPickerSource *peeAccidentQualityPickerSource;
@property (nonatomic, retain)PoopQualityPickerSource *poopQualityPickerSource;
@property (nonatomic,retain)UIToolbar *dateToolBar;
@property (nonatomic, retain)UIToolbar *typeToolBar;
@property (nonatomic, retain)UIToolbar *qualityToolBar;
@property (nonatomic, retain)UIToolbar *toolBarInUse;
@property (nonatomic, retain)UIPickerView *pickerViewInUse;
@property (nonatomic)BOOL datePickerInUse;


@end
