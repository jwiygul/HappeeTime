//
//  PickerDataSource.h
//  UroApp
//
//  Created by Jeremy Wiygul on 10/29/12.
//  Copyright (c) 2012 Jeremy Wiygul. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LogItem.h"

@interface PickerDataSource : NSObject <UIPickerViewDataSource,UIPickerViewDelegate>
{
    NSArray *pickerTypes;
}
@property (nonatomic)NSArray *pickerRowTypes;
@property(nonatomic,retain)LogItem *item;

@end
