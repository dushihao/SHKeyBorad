//
//  SHAlphabetKeyboradView.m
//  SHKeyBorad
//
//  Created by dush on 2018/2/1.
//  Copyright © 2018年 dush. All rights reserved.
//

#import "SHNumberKeyboradFactory.h"
#import "SHAlphabetKeyboradView.h"
#import "SHNumerberKeyboradView.h"
#import "CYRKeyboardButton.h"

@implementation SHAlphabetKeyboradView

#pragma mark - 初始化
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self _commonInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self _commonInit];
    }
    return self;
}

- (void)_commonInit
{
    // 添加滑动手势
    [self _addPanGesture];
}

+ (SHAlphabetKeyboradView *)keyboradView
{
//    NSArray *array = [[UINib nibWithNibName:NSStringFromClass([SHAlphabetKeyboradView class]) bundle:nil] instantiateWithOwner:nil options:nil];
    NSArray *array = [[NSBundle mainBundle]loadNibNamed:NSStringFromClass([SHAlphabetKeyboradView class]) owner:nil options:nil];
    return array[0];
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    // set input
    for (CYRKeyboardButton *button in _keyButtons) {
        button.input = button.currentTitle;
        button.titleLabel.text = @"";
        [button setTitle:@"" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(keyButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    // set other features key
    for (UIButton *btn in _featuresKeyButtons) {
        [btn setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forState:UIControlStateHighlighted];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
        btn.layer.masksToBounds = YES;
    }
}

#pragma mark - Input
- (void)_handleHighlightGestureRecognizer:(UIPanGestureRecognizer *)gestureRecognizer
{
    CGPoint point = [gestureRecognizer locationInView:self];
    
    if (gestureRecognizer.state == UIGestureRecognizerStateChanged || gestureRecognizer.state == UIGestureRecognizerStateEnded) {
        for (CYRKeyboardButton *button in _keyButtons) {
            CGRect buttonRect = [self convertRect:button.frame fromView:button.superview];
            BOOL points = CGRectContainsPoint(buttonRect, point);
            
            if (gestureRecognizer.state == UIGestureRecognizerStateChanged) {
                if (points) {
                    [button sendActionsForControlEvents:UIControlEventTouchDown];
                }else {
                    [button sendActionsForControlEvents:UIControlEventTouchCancel];
                }
            }
            
            if (gestureRecognizer.state == UIGestureRecognizerStateEnded && points) {
                [button sendActionsForControlEvents:UIControlEventTouchUpInside];
            }
        }
    }
}

#pragma mark - IBAction
// 大小写切换
- (IBAction)caseSwitching:(id)sender
{
    UIButton *currentButton = (UIButton *)sender;
    currentButton.selected = !currentButton.selected;
    
    
    for (CYRKeyboardButton *button in _keyButtons) {
        NSString *currentTitle = button.input;
        button.input =   currentButton.selected ? [currentTitle  uppercaseString] : [currentTitle  lowercaseString];
    }
}
// 撤销
- (IBAction)deleteButtonClick:(id)sender
{
    if (![self.input hasText]) return;
    [self.input deleteBackward];
}
// 数字字母切换
- (IBAction)numberLetterConversion:(UIButton *)sender
{
    SHNumerberKeyboradView *keyboard = [[SHNumberKeyboradFactory factory] createKeyboardView];
    keyboard.delegate = self;
    UITextField *textField = (UITextField *)self.input;
    textField.inputView = keyboard;
    [textField reloadInputViews];
}
// 收起键盘
- (IBAction)keyboardDown:(id)sender
{
    [self.input resignFirstResponder];
}
// 空格键
- (IBAction)spaceButtonClick:(id)sender
{
    [self.input insertText:@" "];
}
// 确认按键
- (IBAction)confirmButtonClick:(id)sender
{
    [self.input resignFirstResponder];
}
// 字母按键
- (void)keyButtonClick:(CYRKeyboardButton *)sender
{
    UIResponder<UIKeyInput> *input = self.input;
    [input insertText:sender.input];
}

@end
