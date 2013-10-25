//
//  OutputTypePickerSource.m
//  UroApp
//
//  Created by Jeremy Wiygul on 10/29/12.
//  Copyright (c) 2012 Jeremy Wiygul. All rights reserved.
//

#import "OutputTypePickerSource.h"

@implementation OutputTypePickerSource
@synthesize item;

-(id)init
{
    self = [super init];
    if (self) {
        NSArray *viewArray = [[NSArray alloc]initWithObjects:@"", @"Pee",@"Poop", @"Pee accident",@"Poop accident", nil];
        pickerTypes = viewArray;
    }
    return self;
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [pickerTypes count];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    item.typeOutput = [pickerTypes objectAtIndex:[pickerView selectedRowInComponent:0]];
    item.qualityOutput = nil;
    NSComparisonResult poopAccident = [item.typeOutput compare:@"Poop accident"];
    if (poopAccident == NSOrderedSame && item.typeOutput != nil) {
        item.qualityOutput = @"n/a";
    }
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *returnStr = [pickerTypes objectAtIndex:row];
    return returnStr;
}

@end
