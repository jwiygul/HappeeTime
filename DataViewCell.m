//
//  DataViewCell.m
//  UroApp
//
//  Created by Jeremy Wiygul on 10/29/12.
//  Copyright (c) 2012 Jeremy Wiygul. All rights reserved.
//

#import "DataViewCell.h"

@implementation DataViewCell

@synthesize tableView,controller,typeText,whatText,amountText,timeText,randomImage;



- (IBAction)showTypeIntakePicker:(id)sender
{
    NSString *selector = NSStringFromSelector(_cmd);//creates string from selector of this same function
    selector = [selector stringByAppendingString:@"atIndexPath:"];
    SEL newSelector = NSSelectorFromString(selector);
    NSIndexPath *indexPath = [[self tableView]indexPathForCell:self];
    if (indexPath) {
        if ([[self controller]respondsToSelector:newSelector])
        {
            [[self controller]performSelector:newSelector withObject:sender withObject:indexPath];
        }
    }
    
    
    
}
- (IBAction)showWhatIntakePicker:(id)sender {
    NSString *selector = NSStringFromSelector(_cmd);//creates string from selector of this same function
    selector = [selector stringByAppendingString:@"atIndexPath:"];
    SEL newSelector = NSSelectorFromString(selector);
    NSIndexPath *indexPath = [[self tableView]indexPathForCell:self];
    
    if (indexPath) {
        if ([[self controller]respondsToSelector:newSelector])
        {
            [[self controller]performSelector:newSelector withObject:sender withObject:indexPath];
        }
    }
    
}

- (IBAction)showAmountIntakePicker:(id)sender {
    NSString *selector = NSStringFromSelector(_cmd);//creates string from selector of this same function
    selector = [selector stringByAppendingString:@"atIndexPath:"];
    SEL newSelector = NSSelectorFromString(selector);
    NSIndexPath *indexPath = [[self tableView]indexPathForCell:self];
    if (indexPath) {
        if ([[self controller]respondsToSelector:newSelector])
        {
            [[self controller]performSelector:newSelector withObject:sender withObject:indexPath];
        }
    }
    
}

- (IBAction)showTimePicker:(id)sender
{
    NSString *selector = NSStringFromSelector(_cmd);//creates string from selector of this same function
    selector = [selector stringByAppendingString:@"atIndexPath:"];
    SEL newSelector = NSSelectorFromString(selector);
    NSIndexPath *indexPath = [[self tableView]indexPathForCell:self];
    if (indexPath) {
        if ([[self controller]respondsToSelector:newSelector])
        {
            [[self controller]performSelector:newSelector withObject:sender withObject:indexPath];
        }
    }
    
}
@end
