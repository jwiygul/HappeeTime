//
//  WhatPickerDataSource.h
//  UroApp
//
//  Created by Jeremy Wiygul on 10/29/12.
//  Copyright (c) 2012 Jeremy Wiygul. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LogItem.h"

@interface WhatPickerDataSource : NSObject <UIPickerViewDataSource,UIPickerViewDelegate>

@property(nonatomic,retain)NSArray *whatPickerTypes;
@property(nonatomic,retain)LogItem *item;

@end
