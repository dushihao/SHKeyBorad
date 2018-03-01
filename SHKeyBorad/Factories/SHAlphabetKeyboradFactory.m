//
//  SHAlphabetKeyboradFactory.m
//  SHKeyBorad
//
//  Created by dush on 2018/2/1.
//  Copyright © 2018年 dush. All rights reserved.
//

#import "SHAlphabetKeyboradFactory.h"

@implementation SHAlphabetKeyboradFactory
+ (instancetype)factory
{
    return [[SHAlphabetKeyboradFactory alloc]init];
}

- (SHAlphabetKeyboradView *)createKeyboardView
{
    return (SHAlphabetKeyboradView *)[SHAlphabetKeyboradView keyboradView];
}
@end
