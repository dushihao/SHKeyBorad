//
//  SHKeyboradView.m
//  SHKeyBorad
//
//  Created by dush on 2018/2/1.
//  Copyright © 2018年 dush. All rights reserved.
//

#import "SHKeyboradView.h"

@implementation SHKeyboradView

+ (instancetype)keyboradView
{
    return nil;
}

- (UIResponder *)input
{
    if (!_input) {
        _input = [UIResponder sh_currentFirstResponder];
    }
    return _input;
}

- (void)_addPanGesture
{
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(_handleHighlightGestureRecognizer:)];
    [self addGestureRecognizer:pan];
}

@end

static __weak id currentResponder;
@implementation UIResponder (SH_firstResponder)

+ (instancetype)sh_currentFirstResponder
{
    currentResponder = nil;
    [[UIApplication sharedApplication] sendAction:@selector(currentResponder) to:nil from:nil forEvent:nil];
    return currentResponder;
}

- (void)currentResponder
{
    currentResponder = self;
}
@end
