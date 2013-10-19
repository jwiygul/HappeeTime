//
//  DrinkTypePickerSource.m
//  UroApp
//
//  Created by Jeremy Wiygul on 10/29/12.
//  Copyright (c) 2012 Jeremy Wiygul. All rights reserved.
//

#import "DrinkTypePickerSource.h"

@implementation DrinkTypePickerSource
@synthesize item,drinkTypes;
-(id)init
{
    self = [super init];
    if (self) {
        NSMutableArray *viewArray = [[NSMutableArray alloc]init];
        [viewArray addObject:@""];
        [viewArray addObject:@"Water"];
        [viewArray addObject:@"Juice"];
        [viewArray addObject:@"Cola"];
        [viewArray addObject:@"Milk"];
        [viewArray addObject:@"Tea/Coffee"];
        [viewArray addObject:@"Other"];
        drinkTypes = viewArray;
        
    }
    return self;
}
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return  1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [drinkTypes count];
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    item.whatIntake = [drinkTypes objectAtIndex:[pickerView selectedRowInComponent:0]];
    
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *returnStr = [drinkTypes objectAtIndex:row];
    return returnStr;
    
}

@end
