//
//  PoopQualityPickerSource.h
//  UroApp
//
//  Created by Jeremy Wiygul on 10/29/12.
//  Copyright (c) 2012 Jeremy Wiygul. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OutputLogItem.h"

@interface PoopQualityPickerSource : NSObject < UIPickerViewDataSource, UIPickerViewDelegate>
{
    NSArray *pickerTypes;
    NSArray *poopTypes;
}

@property (nonatomic,retain)OutputLogItem *item;
@property (nonatomic, retain)NSArray *pickerTypes;


@end
