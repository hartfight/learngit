//
//  ViewController.m
//  HomeWorkKVO
//
//  Created by MS on 15-1-14.
//  Copyright (c) 2015年 zyg. All rights reserved.
//

#import "ViewController.h"
#import "FirstViewController.h"



@interface ViewController ()
@property (retain, nonatomic) IBOutlet UITextField *textField;
- (IBAction)buttonClick:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
   
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_textField release];
    [super dealloc];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
- (IBAction)buttonClick:(id)sender {
     FirstViewController *fVC = [[FirstViewController alloc]init];
    fVC.textValue = self.textField.text;
    [fVC addObserver:self forKeyPath:@"textValue" options:0 context:nil];
    
    [self.navigationController pushViewController:fVC animated:YES];
    
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    self.textField.text = ((FirstViewController *)object).textValue;
}







@end
