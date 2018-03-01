//
//  SHNumerberKeyboradView.m
//  SHKeyBorad
//
//  Created by dush on 2018/2/1.
//  Copyright © 2018年 dush. All rights reserved.
//

#import "SHNumerberKeyboradView.h"
#import "SHAlphabetKeyboradFactory.h"

@interface SHNumerberKeyboradView()

@property (nonatomic,strong) NSMutableArray <_KeyboardButton *>*buttonsArray;



@end

@implementation SHNumerberKeyboradView

#pragma mark - 初始化
+ (SHNumerberKeyboradView *)keyboradView
{
    return [[self alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 216)];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self _commonInitWithFrame:frame];
    }
    return self;
}

- (void)_commonInitWithFrame:(CGRect)frame
{
    self.backgroundColor = [UIColor colorFromHexString:@"abb2bd"];
    [self _configButtonsWithType];
    [self _addPanGesture];
    [self setAutoresizingMask: UIViewAutoresizingFlexibleWidth];
}

#pragma mark - Layout
- (void)layoutSubviews
{
    [super layoutSubviews];
    CGRect bounds = (CGRect){.size = self.bounds.size};
    CGFloat keyWidth = (bounds.size.width - 3) / 4;
    CGFloat keyHeight = (bounds.size.height - 3) / 4;
    
    [self.buttonsArray enumerateObjectsUsingBlock:^(_KeyboardButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (obj.keyType == ShKeyTypeDone) { // 确认按钮
            [obj setFrame:CGRectMake((keyWidth + 1)* (idx % 4), (keyHeight + 1) * (idx / 4) + 1, keyWidth, keyHeight * 2)];
        }else{
            [obj setFrame:CGRectMake((keyWidth + 1)* (idx % 4), (keyHeight + 1) * (idx / 4) + 1, keyWidth, keyHeight)];
        }
        [self addSubview:obj];
    }];
}

#pragma mark - Touch event
- (void)keyClick:(_KeyboardButton *)sender // 按键点击回调
{
    ShKeyType keyType = sender.keyType;
    UIResponder<UIKeyInput> *input = self.input;
    
    if (keyType == ShKeyTypeNumber ||
        keyType == ShKeyTypeDot) {
        [input insertText:sender.title];
    }
    // 切换
    else if (keyType == ShKeyTypeNumberSwitch){
        SHAlphabetKeyboradView *alphabetKeyboard = [[SHAlphabetKeyboradFactory factory] createKeyboardView];
        alphabetKeyboard.delegate = self;
        UITextField *tf = (UITextField *)self.input;
        tf.inputView = alphabetKeyboard;
        [self.input reloadInputViews];
    }
    // 确认
    else if (keyType == ShKeyTypeDone){
        [input resignFirstResponder];
    }
    // 清除
    else if (keyType == ShKeyTypeClean){
        UITextField *tf = (UITextField *)input;
        tf.text = @"";
    }
    // 删除
    else if (keyType == ShKeyTypeDelete){
        if ([input hasText]) [input deleteBackward];
    }
}

- (void)deleteBackwardRepeat:(_KeyboardButton *)sender
{
    if (![self.input hasText]) return;
    
    [self.input deleteBackward];
}

#pragma mark - Input.



- (void)_handleHighlightGestureRecognizer:(UIPanGestureRecognizer *)gestureRecognizer
{
    CGPoint point = [gestureRecognizer locationInView:self];
    
    if (gestureRecognizer.state == UIGestureRecognizerStateChanged || gestureRecognizer.state == UIGestureRecognizerStateEnded) {
        for (UIButton *button in self.buttonsArray) {
            BOOL points = CGRectContainsPoint(button.frame, point) && !button.isHidden;
            
            if (gestureRecognizer.state == UIGestureRecognizerStateChanged) {
                [button setHighlighted:points];
            } else {
                [button setHighlighted:NO];
            }
            
            if (gestureRecognizer.state == UIGestureRecognizerStateEnded && points) {
                [button sendActionsForControlEvents:UIControlEventTouchUpInside];
            }
        }
    }
}

#pragma mark - Setter & getter

- (NSMutableArray *)buttonsArray
{
    if (!_buttonsArray) {
        _buttonsArray = [NSMutableArray arrayWithCapacity:16];
    }
    return _buttonsArray;
}


#pragma mark - Convenience
- (void)_configButtonsWithType
{
    NSArray *tempArray =
    @[
      @{ @"1": @(ShKeyTypeNumber)},@{ @"2": @(ShKeyTypeNumber)},@{ @"3": @(ShKeyTypeNumber)},@{ @"": @(ShKeyTypeDelete)},
      @{ @"4": @(ShKeyTypeNumber)},@{ @"5": @(ShKeyTypeNumber)},@{ @"6": @(ShKeyTypeNumber)},@{ @"清除": @(ShKeyTypeClean)},
      @{ @"7": @(ShKeyTypeNumber)},@{ @"8": @(ShKeyTypeNumber)},@{ @"9": @(ShKeyTypeNumber)},@{ @"确认": @(ShKeyTypeDone)},
      @{ @"ABC":@(ShKeyTypeNumberSwitch)},@{ @"0": @(ShKeyTypeNumber)},@{ @".": @(ShKeyTypeDot)},
      ];
    
    [tempArray enumerateObjectsUsingBlock:^(NSDictionary *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        ShKeyType keyType = [obj.allValues.firstObject unsignedIntegerValue];
        NSString *title = obj.allKeys.firstObject;
        
        _KeyboardButton *btn = [_KeyboardButton configKeyboardButtonWithButtonType:keyType title:title];
        if (btn.keyType == ShKeyTypeDelete) {
            [btn addTarget:self action:@selector(deleteBackwardRepeat:) forContinuousPressWithDelay:.15];
        }
        [btn addTarget:self action:@selector(keyClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.buttonsArray addObject:btn];
    }];
}




@end

@interface _KeyboardButton()
@property (nonatomic,assign) NSTimeInterval delayTimeInterval;
@property (nonatomic,strong) NSTimer *timer;
@end

@implementation _KeyboardButton

+ (instancetype)configKeyboardButtonWithButtonType:(ShKeyType)style title:(NSString *)title
{
    _KeyboardButton *button = [self buttonWithType:UIButtonTypeCustom];
    button.keyType = style;
    button.title = title;
    return button;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 默认背景色
        self.exclusiveTouch = YES;
        self.backgroundColor = [UIColor whiteColor];
        [self setTitleColor:[UIColor blackColor]];
    }
    return self;
}

#pragma mark - Setter & Geter
- (void)setTitle:(NSString *)title
{
    _title = title;
    [self setTitle:title forState:UIControlStateNormal];
}

- (void)setTitleColor:(UIColor *)titleColor
{
    _titleColor = titleColor;
    [self setTitleColor:titleColor forState:UIControlStateNormal];
}

- (void)setTitleSelectColor:(UIColor *)titleSelectColor
{
    _titleSelectColor = titleSelectColor;
    [self setTitleColor:titleSelectColor forState:UIControlStateHighlighted];
}

- (void)setKeyType:(ShKeyType)keyType
{
    _keyType = keyType;
    UIColor *normalColor, *sColor;
    if (keyType == ShKeyTypeNumber ||
        keyType == ShKeyTypeDot ||
        keyType == ShKeyTypeNumberSwitch){
        normalColor = [UIColor whiteColor];
        sColor = [UIColor colorFromHexString:@"d1d5db"];
    }
    
    else if (keyType == ShKeyTypeDone){
        normalColor = [UIColor colorFromHexString:@"4359aa"];
        sColor = [UIColor whiteColor];
        self.titleColor = [UIColor whiteColor];
        self.titleSelectColor = [UIColor blackColor];
    }
    
    else{
        normalColor = [UIColor colorFromHexString:@"d1d5db"];
        sColor = [UIColor whiteColor];
    }
    
    if (keyType == ShKeyTypeDelete) {
        [self setImage:[UIImage imageNamed:@"keyboard_delete"] forState:UIControlStateNormal];
    }
    self.normalColor = normalColor;
    self.selectColor = sColor;
}

- (void)setNormalColor:(UIColor *)normalColor
{
    _normalColor = normalColor;
    [self setBackgroundColor:normalColor];
}

- (void)setSelectColor:(UIColor *)selectColor
{
    _selectColor = selectColor;
    [self setBackgroundImage:[UIImage imageWithColor:selectColor] forState: UIControlStateHighlighted];
}

#pragma mark - Continous press
- (void)addTarget:(id)target action:(SEL)action forContinuousPressWithDelay:(NSTimeInterval)timeInterval
{
    self.delayTimeInterval = timeInterval;
    [self addTarget:target action:action forControlEvents:UIControlEventValueChanged];
}

- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    BOOL begin = [super beginTrackingWithTouch:touch withEvent:event];
    NSTimeInterval time = self.delayTimeInterval;
    if (begin && time > 0) {
        [self performSelector:@selector(_beginTimer) withObject:self afterDelay:_delayTimeInterval * 2];
    }
    
    return begin;
}

- (void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    [super endTrackingWithTouch:touch withEvent:event];
    [self _cancelTimer];
}


- (void)_beginTimer
{
    if (!self.tracking && _delayTimeInterval == 0) {
        return;
    }
    __weak __typeof__(self) weakSelf = self;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:_delayTimeInterval repeats:YES block:^(NSTimer * _Nonnull timer) {
        if (!weakSelf.tracking) {
            [weakSelf _cancelTimer];
            return ;
        }
        [weakSelf sendActionsForControlEvents:UIControlEventValueChanged];
    }];
}

- (void)_cancelTimer
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(_beginTimer) object:nil];
    
    if (!_timer) return;
    [_timer invalidate];
    _timer = nil;
}

- (void)dealloc
{
    _timer = nil;
}

@end
