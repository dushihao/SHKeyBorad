//
//  ViewController.m
//  SHKeyBorad
//
//  Created by dush on 2018/2/1.
//  Copyright © 2018年 dush. All rights reserved.
//

#import "ViewController.h"
#import "SHNumberKeyboradFactory.h"
#import "SHNumerberKeyboradView.h"

#import "SHAlphabetKeyboradFactory.h"
#import "SHAlphabetKeyboradView.h"

@interface ViewController ()<SHKeyboradViewDelegate>
@property (nonatomic,weak) IBOutlet UITextField *textField;

@property (nonatomic,weak) IBOutlet UITextField *secondeTextField;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    SHNumerberKeyboradView *keyboard = [[SHNumberKeyboradFactory factory] createKeyboardView];
    keyboard.delegate = self;
    _textField.inputView = keyboard;
    
    SHAlphabetKeyboradView *alphabetKeyboard = [[SHAlphabetKeyboradFactory factory] createKeyboardView];
    alphabetKeyboard.delegate = self;
    _secondeTextField.inputView = alphabetKeyboard;
    
}

- (BOOL)keyboardView:(SHKeyboradView *)keyboardView shouldInsertText:(NSString *)text
{
    return YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}


@end
