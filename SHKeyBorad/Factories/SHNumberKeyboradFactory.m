//
//  SHNumberKeyboradFactory.m
//  SHKeyBorad
//
//  Created by dush on 2018/2/1.
//  Copyright © 2018年 dush. All rights reserved.
//

#import "SHNumberKeyboradFactory.h"
#import "SHNumerberKeyboradView.h"

@implementation SHNumberKeyboradFactory

+ (instancetype)factory
{
    return [[SHNumberKeyboradFactory alloc]init];
}

- (SHNumerberKeyboradView *)createKeyboardView
{
    return (SHNumerberKeyboradView *)[SHNumerberKeyboradView keyboradView];
}
@end
