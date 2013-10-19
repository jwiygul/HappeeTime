//
//  WhatPickerDataSource.m
//  UroApp
//
//  Created by Jeremy Wiygul on 10/29/12.
//  Copyright (c) 2012 Jeremy Wiygul. All rights reserved.
//

#import "WhatPickerDataSource.h"

@implementation WhatPickerDataSource
@synthesize whatPickerTypes, item;
-(id)init
{
    self = [super init];
    if (self) {
        NSMutableArray *viewArray = [[NSMutableArray alloc]init];
        [viewArray addObject:@""];
        [viewArray addObject:@"Meat/Fish"];
        [viewArray addObject:@"Fruits/Veggies"];
        [viewArray addObject:@"Pasta/Bread/Cereal"];
        [viewArray addObject:@"Milk/Cheese/Yogurt"];
        [viewArray addObject:@"Other"];
        
        whatPickerTypes = viewArray;
        
    }
    return self;
}
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return  1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [whatPickerTypes count];
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    item.whatIntake = [whatPickerTypes objectAtIndex:[pickerView selectedRowInComponent:0]];
    
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *returnStr = [whatPickerTypes objectAtIndex:row];
    return returnStr;
    
}

@end
