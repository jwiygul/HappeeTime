//
//  FiberAmountPickerDataSource.h
//  UroApp
//
//  Created by Jeremy Wiygul on 10/29/12.
//  Copyright (c) 2012 Jeremy Wiygul. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LogItem.h"

@interface FiberAmountPickerDataSource : NSObject <UIPickerViewDataSource,UIPickerViewDelegate>

@property (nonatomic,retain)NSArray *amountPickerTypes;
@property (nonatomic, retain)LogItem *item;
@property (nonatomic,retain)NSArray *amountNumberTypes;


@end
