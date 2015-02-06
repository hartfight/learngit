//
//  FirstViewController.m
//  HomeWorkKVO
//
//  Created by MS on 15-1-14.
//  Copyright (c) 2015年 zyg. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()
@property (retain, nonatomic) IBOutlet UITextField *textField;
- (IBAction)buttonClick:(id)sender;

@end

@implementation FirstViewController
@synthesize textValue = _textValue;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.textField.text = self.textValue;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)dealloc {
    [_textField release];
    [_textValue release];
    [super dealloc];
}
- (IBAction)buttonClick:(id)sender {
    self.textValue = self.textField.text;
    [self.navigationController popToRootViewControllerAnimated:YES];
}
@end
