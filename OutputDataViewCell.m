//
//  OutputDataViewCell.m
//  UroApp
//
//  Created by Jeremy Wiygul on 10/29/12.
//  Copyright (c) 2012 Jeremy Wiygul. All rights reserved.
//

#import "OutputDataViewCell.h"

@implementation OutputDataViewCell

@synthesize timeField,typeField,qualityField,tableView,controller,randomImage;

- (IBAction)qualityPickerButton:(id)sender
{
    NSString *selector = NSStringFromSelector(_cmd);
    SEL newSelector = NSSelectorFromString(selector);
    
    if ([[self controller]respondsToSelector:newSelector])
    {
        [[self controller]performSelector:newSelector withObject:sender withObject:nil];
    }
    
    
}

- (IBAction)typePickerButton:(id)sender
{
    NSString *selector = NSStringFromSelector(_cmd);
    SEL newSelector = NSSelectorFromString(selector);
    
    if ([[self controller]respondsToSelector:newSelector])
    {
        [[self controller]performSelector:newSelector withObject:sender withObject:nil];
    }
    
}

- (IBAction)timePickerButton:(id)sender
{
    
    NSString *selector = NSStringFromSelector(_cmd);
    SEL newSelector = NSSelectorFromString(selector);
    
    if ([[self controller]respondsToSelector:newSelector])
    {
        [[self controller]performSelector:newSelector withObject:sender withObject:nil];
    }
}
@end
