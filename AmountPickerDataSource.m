//
//  AmountPickerDataSource.m
//  UroApp
//
//  Created by Jeremy Wiygul on 10/29/12.
//  Copyright (c) 2012 Jeremy Wiygul. All rights reserved.
//

#import "AmountPickerDataSource.h"

@implementation AmountPickerDataSource
@synthesize amountPickerTypes,item, amountNumberTypes;
-(id)init
{
    self = [super init];
    if (self) {
        NSMutableArray *viewArray = [[NSMutableArray alloc]init];
        [viewArray addObject:@""];
        [viewArray addObject:@"5 oz"];
        [viewArray addObject:@"10 oz"];
        [viewArray addObject:@"15 oz"];
        [viewArray addObject:@"20 oz"];
        [viewArray addObject:@"25 oz"];
        [viewArray addObject:@"30 oz"];
        [viewArray addObject:@"35 oz"];
        [viewArray addObject:@"40 oz"];
        [viewArray addObject:@"45 oz"];
        [viewArray addObject:@"50 oz"];
        
        self.amountPickerTypes = viewArray;
        NSMutableArray *viewerArray = [[NSMutableArray alloc]init];
        [viewerArray addObject:[NSNumber numberWithInt:0]];
        [viewerArray addObject:[NSNumber numberWithInt:5]];
        [viewerArray addObject:[NSNumber numberWithInt:10]];
        [viewerArray addObject:[NSNumber numberWithInt:15]];
        [viewerArray addObject:[NSNumber numberWithInt:20]];
        [viewerArray addObject:[NSNumber numberWithInt:25]];
        [viewerArray addObject:[NSNumber numberWithInt:30]];
        [viewerArray addObject:[NSNumber numberWithInt:35]];
        [viewerArray addObject:[NSNumber numberWithInt:40]];
        [viewerArray addObject:[NSNumber numberWithInt:45]];
        [viewerArray addObject:[NSNumber numberWithInt:50]];
        amountNumberTypes = viewerArray;
        
    }
    return self;
}
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return  1;
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
