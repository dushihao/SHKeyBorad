//
//  SHKeyboradView.h
//  SHKeyBorad
//
//  Created by dush on 2018/2/1.
//  Copyright © 2018年 dush. All rights reserved.
//

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

#import <UIKit/UIKit.h>
#import "SHKeyboradView.h"
#import "UIImage+SHImageColor.h"
#import "Colours.h"

@class SHKeyboradView;
@protocol SHKeyboradViewDelegate <NSObject>

@optional
- (BOOL)keyboardView:(SHKeyboradView *)keyboardView shouldInsertText:(NSString *)text;
- (BOOL)keyboardViewShouldDeleteBackward:(SHKeyboradView *)keyboardView;
@end

// 按键类型
typedef NS_ENUM(NSUInteger, ShKeyType) {
    ShKeyTypeNumber, // 数字键
    ShKeyTypeDot, // 小数点
    ShKeyTypeNumberSwitch, // 切换键
    ShKeyTypeDelete, // 删除键
    ShKeyTypeDone,   // 确认键
    ShKeyTypeClean, // 清除
    ShKeyTypeHidden, // 隐藏
};

@interface SHKeyboradView : UIInputView <SHKeyboradViewDelegate>

@property (nonatomic,weak) id<SHKeyboradViewDelegate> delegate;

@property (nonatomic,weak) UIResponder<UIKeyInput> *input;

+ (SHKeyboradView *)keyboradView;

- (void)_addPanGesture;
@end

// key
@interface _KeyboardButton : UIButton

/// 按键类型
@property (nonatomic,assign) ShKeyType keyType;
/// 标题
@property (nonatomic,copy) NSString *title;
/// 标题颜色
@property (nonatomic,strong) UIColor *titleColor;
/// 标题选中颜色
@property (nonatomic,strong) UIColor *titleSelectColor;
/// 默认背景色
@property (nonatomic,strong) UIColor *normalColor;
/// 选中背景色
@property (nonatomic,strong) UIColor *selectColor;

+ (instancetype)configKeyboardButtonWithButtonType:(ShKeyType)style title:(NSString *)title;

- (void)addTarget:(id)target action:(SEL)action forContinuousPressWithDelay:(NSTimeInterval)timeInterval;


@end

@interface UIResponder (SH_firstResponder)

+ (instancetype)sh_currentFirstResponder;

@end
