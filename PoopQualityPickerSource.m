//
//  PoopQualityPickerSource.m
//  UroApp
//
//  Created by Jeremy Wiygul on 10/29/12.
//  Copyright (c) 2012 Jeremy Wiygul. All rights reserved.
//

#import "PoopQualityPickerSource.h"
#import "BristolView.h"

@implementation PoopQualityPickerSource
@synthesize item,pickerTypes;

-(id)init
{
    self = [super init];
    if (self) {
        
        NSMutableArray *viewArray = [[NSMutableArray alloc]init];
        BristolView *blankView = [[BristolView alloc]init];
        [viewArray addObject:blankView];
        
        BristolView *blankView2 = [[BristolView alloc]init];
        [viewArray addObject:blankView2];
        
        BristolView *blankView3=[[BristolView alloc]init];
        [viewArray addObject:blankView3];
        
        BristolView * type1View = [[BristolView alloc]initWithFrame:CGRectZero];
        type1View.title = @"Type 1";
        type1View.image = [UIImage imageNamed:@"Type1.png"];
        [viewArray addObject:type1View];
        
        BristolView * type2View = [[BristolView alloc]initWithFrame:CGRectZero];
        type2View.title = @"Type 2";
        type2View.image = [UIImage imageNamed:@"Type2.png"];
        [viewArray addObject:type2View];
        
        BristolView * type3View = [[BristolView alloc]initWithFrame:CGRectZero];
        type3View.title = @"Type 3";
        type3View.image = [UIImage imageNamed:@"Type3.png"];
        [viewArray addObject:type3View];
        
        BristolView * type4View = [[BristolView alloc]initWithFrame:CGRectZero];
        type4View.title = @"Type 4";
        type4View.image = [UIImage imageNamed:@"Type4.png"];
        [viewArray addObject:type4View];
        
        
        BristolView * type5View = [[BristolView alloc]initWithFrame:CGRectZero];
        type5View.title = @"Type 5";
        type5View.image = [UIImage imageNamed:@"Type5.png"];
        [viewArray addObject:type5View];
        
        
        BristolView * type6View = [[BristolView alloc]initWithFrame:CGRectZero];
        type6View.title = @"Type 6";
        type6View.image = [UIImage imageNamed:@"Type6.png"];
        [viewArray addObject:type6View];
        
        
        BristolView * type7View = [[BristolView alloc]initWithFrame:CGRectZero];
        type7View.title = @"Type 7";
        type7View.image = [UIImage imageNamed:@"Type7.png"];
        [viewArray addObject:type7View];
        
        NSMutableArray *anotherArray = [[NSMutableArray alloc]initWithObjects:@"",@"",@"",@"Type 1",@"Type 2",@"Type 3",@"Type 4",@"Type 5",@"Type 6",@"Type 7", nil];
        pickerTypes = viewArray;
        poopTypes = anotherArray;
        
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
    item.qualityOutput = [poopTypes objectAtIndex:[pickerView selectedRowInComponent:0]];
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *returnStr = [pickerTypes objectAtIndex:row];
    return returnStr;
}

-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return [BristolView viewHeight];
}

-(CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    return [BristolView viewWidth];
}

-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    // self.myImages is an array of UIImageView objects
    UIView * myView = [pickerTypes objectAtIndex:row];
    
    // first convert to a UIImage
    UIGraphicsBeginImageContextWithOptions(myView.bounds.size, NO, 0);
    
    [myView.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    // then convert back to a UIImageView and return it
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    
    return imageView;
    //return [pickerTypes objectAtIndex:row];
}

@end
