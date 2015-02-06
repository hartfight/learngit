//
//  ZYGRootViewController.m
//  Calculator
//
//  Created by MS on 14-12-24.
//  Copyright (c) 2014年 zyg. All rights reserved.
//

#import "ZYGRootViewController.h"

char operat = ' ';
float count = 0.0;

@interface ZYGRootViewController ()

@end

@implementation ZYGRootViewController


@synthesize  label = _label;

- (void)dealloc{
    [_label release];
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        
        
    }
    return self;
}



- (void)loadView{
    [super loadView];
    //    设置控制器的view属性的背景颜色
    self.view.backgroundColor = [UIColor grayColor];
    //    label设置：
    int screenWieth = [[UIScreen mainScreen] bounds].size.width;
    int screeHeight = [[UIScreen mainScreen] bounds].size.height;
    
    _label = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, screenWieth-20, 100)];
    self.label.backgroundColor = [UIColor blackColor];
    [self.label setTextAlignment:NSTextAlignmentRight];
    //    self.label.font = [UIFont systemFontOfSize:80];
    self.label.textColor = [UIColor whiteColor];
    self.label.adjustsFontSizeToFitWidth = YES;
    self.label.text = @"0";
    [self.view addSubview:self.label];
    
    
    NSArray *array = @[@"AC",@"+/-",@"%",@"/",@"7",@"8",@"9",@"X",@"4",@"5",@"6",@"-",@"1",@"2",@"3",@"+",@"0",@".",@"<-",@"="];
    for (int i = 0; i<5 ; i++) {
        for (int j = 0; j<4; j++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(10+j*(screenWieth-20)/4.0, i*(screeHeight-100)/5+100,(screenWieth-20)/4.0-3 , (screeHeight-100)/5-3);
            button.backgroundColor = [UIColor lightGrayColor];
            if (j == 3) {
                button.frame = CGRectMake(10+j*(screenWieth-20)/4.0, i*(screeHeight-100)/5+100,(screenWieth-20)/4.0, (screeHeight-100)/5-3);
                button.backgroundColor = [UIColor orangeColor];
            }
            [button setTitle:array[i*4+j] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
            [button addTarget:self action:@selector(buttonCliked:) forControlEvents:UIControlEventTouchUpInside];
            
            [self.view addSubview:button];
            [button release];
            
            
        }
    }
    
}
int operatFlag1 = 1;
int operatFlag2 = 1;
#pragma mark ------判断要进行的操作
- (void)buttonCliked:(UIButton *)sender {
    NSString *str = sender.currentTitle;
    char chFlg = [str characterAtIndex:0];
    
    if (chFlg != '=') {
        
        self.label.text = [ ZYGRootViewController  lableValue:self.label andString:str andCharFlg:chFlg];
    } else if(chFlg == '=') {
        self.label.text = [NSString stringWithFormat:@"%d",[[ZYGRootViewController alloc] calcString:_label.text]];
    }
    if ([str isEqual:@"AC"]) {
     
        self.label.text = @"";
    }
    
    [str release];
}

//数据的录入，结果显示。
+ (NSString *)lableValue:(UILabel *)label andString:(NSString *)str andCharFlg:(char)chFlg{
//    NSInteger lastNum = [[label.text substringToIndex:[label.text length]] integerValue ];
//    [label.text rangeOfString:@"."].length == 0 ||([label.text rangeOfString:@"."].length >0 && chFlg != '.')
    
    
                label.text = [NSString stringWithFormat:@"%@%@",label.text,str];
    

    return label.text;
}

//operate运算。
+(NSString *)resultLableValue:(UILabel *)label andString:(NSString *)str andCharFlg:(char)chFlg{
    return nil;
}

//=号运算；
+(NSString *)stringEqual:(UILabel *)label{
    
    label.text = [NSString stringWithFormat:@"%d",[[ZYGRootViewController alloc]calcString:label.text] ];
    return label.text;
    
}

-(NSMutableArray *)separatorStr:(NSString*)string;{
    NSMutableString *muString=[NSMutableString stringWithString:string];
    NSMutableArray *nuArray=[NSMutableArray arrayWithCapacity:0];
    
    while (muString!=nil) {
        NSString *temStr=[NSString stringWithFormat:@"%d",[muString integerValue]];
        [nuArray addObject:temStr];
        NSRange range=[muString rangeOfString:temStr];
        if ([muString length]==range.length) {
            break;
        }
        [muString setString:[muString substringFromIndex:range.length+range.location+1]];
    }
    return nuArray;
}
-(NSMutableString *)flg:(NSString *)string{
    NSMutableString *flgStr=[NSMutableString stringWithCapacity:0];
    char ch=' ';
    for (NSInteger i=1; i<[string length]-1; i++) {
        ch=[string characterAtIndex:i];
        if (ch=='X'||ch=='/'||ch=='+'||ch=='-') {
            [flgStr appendFormat:@"%c",ch];
        }
    }
    return flgStr;
}

-(NSInteger )calcString:(NSString *)mathString{
    NSMutableArray *numArray=[[ZYGRootViewController alloc] separatorStr:mathString];
    int ret=0;
    NSInteger flg=[numArray count]-1;
    NSMutableString *flgstr=[[ZYGRootViewController alloc]flg:mathString];
    NSInteger j=0;
    NSInteger i=0;
    while (flg!=0&&![flgstr isEqual:@""]) {
        NSInteger l=flg;//查看是否进行了乘除运算
        i=0;
        for ( i=0; i<[flgstr length]; i++) {
            if ([flgstr characterAtIndex:i]=='X') {
                ret=[numArray[i] intValue ]*[numArray[i+1] intValue];
                NSString *nuStr=[NSString stringWithFormat:@"%d",ret];
                NSRange range={i,1};
                [flgstr deleteCharactersInRange:range];
                [numArray removeObjectAtIndex:i];
                [numArray removeObjectAtIndex:i];
                [numArray insertObject:nuStr atIndex:i];
                flg--;
                break;
            }else if([flgstr characterAtIndex:i]=='/'){
                ret=[numArray[i] intValue ]/[numArray[i+1] intValue];
                NSString *nuStr=[NSString stringWithFormat:@"%d",ret];
                NSRange range={i,1};
                [flgstr deleteCharactersInRange:range];
                [numArray removeObjectAtIndex:i];
                [numArray removeObjectAtIndex:i];
                [numArray insertObject:nuStr atIndex:i];
                flg--;
                break;
            }
        }
        if (flg!=l) {
            continue;
        }
        
        for ( j=0; j<[flgstr length]; j++) {
            if ([flgstr characterAtIndex:j]=='+') {
                ret=[numArray[j] intValue ]+[numArray[j+1] intValue];
                NSString *nuStr=[NSString stringWithFormat:@"%d",ret];
                NSRange range={j,1};
                [flgstr deleteCharactersInRange:range];
                [numArray removeObjectAtIndex:j];
                [numArray removeObjectAtIndex:j];
                [numArray insertObject:nuStr atIndex:j];
                flg--;
                break;
            }else if([flgstr characterAtIndex:j]=='-'){
                ret=[numArray[j] intValue ]-[numArray[j+1] intValue];
                NSString *nuStr=[NSString stringWithFormat:@"%d",ret];
                NSRange range={j,1};
                [flgstr deleteCharactersInRange:range];
                [numArray removeObjectAtIndex:j];
                [numArray removeObjectAtIndex:j];
                [numArray insertObject:nuStr atIndex:j];
                flg--;
                break;
            }
        }
        
    }
    
    
    
    return ret;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
