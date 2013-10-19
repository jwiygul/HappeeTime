//
//  PeeAccidentQualityPickerSource.m
//  UroApp
//
//  Created by Jeremy Wiygul on 10/29/12.
//  Copyright (c) 2012 Jeremy Wiygul. All rights reserved.
//

#import "PeeAccidentQualityPickerSource.h"

@implementation PeeAccidentQualityPickerSource
@synthesize item;
-(id)init
{
    self = [super init];
    if (self) {
        NSArray *viewArray = [[NSArray alloc]initWithObjects:@"",@"",@"",@"",@"spotted underwear",@"soaked underwear",@"soaked pants", nil];
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
    item.qualityOutput = [pickerTypes objectAtIndex:[pickerView selectedRowInComponent:0]];
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *returnStr = [pickerTypes objectAtIndex:row];
    return returnStr;
}

@end
