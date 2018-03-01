//
//  SHAlphabetKeyboradView.h
//  SHKeyBorad
//
//  Created by dush on 2018/2/1.
//  Copyright © 2018年 dush. All rights reserved.
//

#import "SHKeyboradView.h"
@class CYRKeyboardButton;

@interface SHAlphabetKeyboradView : SHKeyboradView

@property (strong, nonatomic) IBOutletCollection(CYRKeyboardButton) NSArray *keyButtons;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *featuresKeyButtons;

@end
