//
//  ViewController.m
//  ZWRE_zzwu
//
//  Created by zzzzwu on 16/1/28.
//  Copyright © 2016年 zzzzwu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITextFieldDelegate>

@property(nonatomic,weak)UITextField *tf;
@property(nonatomic,weak)UILabel *tf1;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UITextField *tf = [[UITextField alloc] initWithFrame:CGRectMake(50, 200, 150, 20)];
    [self.view addSubview:tf];
    tf.borderStyle = UITextBorderStyleRoundedRect;
    self.tf = tf;
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(tf.frame.size.width + tf.frame.origin.x + 10, tf.frame.origin.y, 50, 20)];
    [self.view addSubview:btn];
    [btn setTitle:@"确定" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(wu_btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *tf1 = [[UILabel alloc] initWithFrame:CGRectMake(tf.frame.origin.x, tf.frame.size.height + tf.frame.origin.y + 10, 200, 20)];
    [self.view addSubview:tf1];
    self.tf1 = tf1;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.tf resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.tf resignFirstResponder];
    return YES;
}

-(void)wu_btnClick:(UIButton *)button
{
    [self wu_validateIdentityCard:self.tf.text] ? (self.tf1.text = [NSString stringWithFormat:@"YES"]) : (self.tf1.text = [NSString stringWithFormat:@"NO"]);    
}

//车牌号验证
- (BOOL) wu_validateCarNo:(NSString *)carNo
{
    NSString *carRegex = @"^[\u4e00-\u9fa5]{1}[a-zA-Z]{1}[a-zA-Z_0-9]{4}[a-zA-Z_0-9_\u4e00-\u9fa5]$";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",carRegex];
    NSLog(@"carTest is %@",carTest);
    return [carTest evaluateWithObject:carNo];
}

//邮箱
- (BOOL) wu_validateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

//手机号码验证
- (BOOL) wu_validateMobile:(NSString *)mobile
{
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]|(14[0-9])|(17[0-9])))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}

//身份证号
- (BOOL) wu_validateIdentityCard: (NSString *)identityCard
{
    BOOL flag;
    if (identityCard.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:identityCard];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
