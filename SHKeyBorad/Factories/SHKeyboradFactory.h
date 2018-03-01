//
//  SHKeyboradFactory.h
//  SHKeyBorad
//
//  Created by dush on 2018/2/1.
//  Copyright © 2018年 dush. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SHKeyboradView.h"

typedef NS_ENUM(NSUInteger, keyboradType) {
    keyboradTypeDefault,
    keyboradTypeAlphabet,
    keyboradTypeNumber,
};
@interface SHKeyboradFactory : NSObject

+ (instancetype)factory;

- (id)createKeyboardView;
@end
