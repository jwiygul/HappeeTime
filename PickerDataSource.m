//
//  PickerDataSource.m
//  UroApp
//
//  Created by Jeremy Wiygul on 10/29/12.
//  Copyright (c) 2012 Jeremy Wiygul. All rights reserved.
//

#import "PickerDataSource.h"

@implementation PickerDataSource 
@synthesize pickerRowTypes,item;
-(id)init
{
    self = [super init];
    if (self) {
        NSMutableArray *viewArray = [[NSMutableArray alloc]init];
        [viewArray addObject:@""];
        [viewArray addObject:@"Food"];
        [viewArray addObject:@"Drink"];
        [viewArray addObject:@"Fiber"];
        self.pickerRowTypes = viewArray;
        
    }
    return self;
}
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return  1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [pickerRowTypes count];
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    item.typeIntake = [pickerRowTypes objectAtIndex:[pickerView selectedRowInComponent:0]];
    NSComparisonResult result = [item.typeIntake compare:@"Fiber"];
    NSComparisonResult foodResult = [item.typeIntake compare:@"Food"];
    NSComparisonResult drinkResult = [item.typeIntake compare:@"Drink"];
    if (result == NSOrderedSame && item.typeIntake !=nil) {
        item.whatIntake = @"Fiber";
        item.amountIntake = nil;//this is to reset variable in case muitiple selections were made during same spin of picker
    }
    else if (foodResult == NSOrderedSame && item.typeIntake != nil) {
        NSNumber *number = [NSNumber numberWithInt:0];
        item.amountIntake = number;
        item.whatIntake = nil;
    }
    else if (drinkResult == NSOrderedSame && item.typeIntake != nil)
    {
        item.whatIntake = nil;
        item.amountIntake = nil;
    }
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *returnStr = [pickerRowTypes objectAtIndex:row];
    return returnStr;
    
}
@end
