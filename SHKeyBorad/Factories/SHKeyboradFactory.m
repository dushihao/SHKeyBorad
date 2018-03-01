//
//  SHKeyboradFactory.m
//  SHKeyBorad
//
//  Created by dush on 2018/2/1.
//  Copyright © 2018年 dush. All rights reserved.
//

#import "SHKeyboradFactory.h"
#import "SHNumberKeyboradFactory.h"
#import "SHAlphabetKeyboradFactory.h"

@implementation SHKeyboradFactory

+ (instancetype)factory
{
    // 需要子类去实现
    return nil;
}

+ (instancetype)factoryWithType:(keyboradType)keyboardType
{
    switch (keyboardType) {
        case keyboradTypeDefault:
        case keyboradTypeNumber:
            {
                return [SHNumberKeyboradFactory factory];
            }
            break;
        case keyboradTypeAlphabet:
            {
                return [SHAlphabetKeyboradFactory factory];
            }
            break;
        default:
            break;
    }
    return nil;
}

- (id)createKeyboardView
{
    return nil;
}
@end
