//
//  PeeQualityPickerSource.h
//  UroApp
//
//  Created by Jeremy Wiygul on 10/29/12.
//  Copyright (c) 2012 Jeremy Wiygul. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OutputLogItem.h"

@interface PeeQualityPickerSource : NSObject <UIPickerViewDataSource,UIPickerViewDelegate>
{
    NSArray *pickerTypes;
}

@property (nonatomic, retain)OutputLogItem *item;


@end
