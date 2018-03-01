//
//  UIImage+SHImageColor.m
//  SHKeyBorad
//
//  Created by dush on 2018/2/7.
//  Copyright © 2018年 dush. All rights reserved.
//

#import "UIImage+SHImageColor.h"

@implementation UIImage (SHImageColor)
+ (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = (CGRect){0,0,1,1};
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}
@end
