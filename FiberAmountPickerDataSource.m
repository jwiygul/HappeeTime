//
//  FiberAmountPickerDataSource.m
//  UroApp
//
//  Created by Jeremy Wiygul on 10/29/12.
//  Copyright (c) 2012 Jeremy Wiygul. All rights reserved.
//

#import "FiberAmountPickerDataSource.h"

@implementation FiberAmountPickerDataSource
@synthesize item,amountNumberTypes,amountPickerTypes;
-(id)init
{
    self = [super init];
    if (self) {
        NSMutableArray *viewArray = [[NSMutableArray alloc]init];
        [viewArray addObject:@""];
        [viewArray addObject:@"1 gm"];
        [viewArray addObject:@"2 gm"];
        
        [viewArray addObject:@"3 gm"];
        
        [viewArray addObject:@"4 gm"];
        
        [viewArray addObject:@"5 gm"];
        
        [viewArray addObject:@"10 gm"];
        
        [viewArray addObject:@"15 gm"];
        
        [viewArray addObject: @"20 gm"];
        
        self.amountPickerTypes = viewArray;
        NSMutableArray *numberArray = [[NSMutableArray alloc]initWithObjects:[NSNumber numberWithInt:0],[NSNumber numberWithInt:1],[NSNumber numberWithInt:2],[NSNumber numberWithInt:3],[NSNumber numberWithInt:4],[NSNumber numberWithInt:5],[NSNumber numberWithInt:10],[NSNumber numberWithInt:15],[NSNumber numberWithInt:20], nil];
        self.amountNumberTypes = numberArray;
    }
    return self;
}
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [amountPickerTypes count];
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    item.amountIntake = [amountNumberTypes objectAtIndex:[pickerView selectedRowInComponent:0]];
    
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *returnStr = [amountPickerTypes objectAtIndex:row];
    return returnStr;
}

@end
