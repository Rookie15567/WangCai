//
//  LoginViewController.m
//  WangCai
//
//  Created by cds on 16/12/6.
//  Copyright © 2016年 cds. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginBackView.h"
@interface LoginViewController ()<keyBoardDelegate>
{
    NSTimer * _time;
}
@property (nonatomic,strong)LoginBackView * loginBack;
@property (nonatomic,strong)KeyBoard * keyBoard;
@property (nonatomic,strong)UIView * keyView;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
    self.view.backgroundColor = [UIColor whiteColor];
    [self registerForKeyboardNotifications];
    NSLog(@"CFBundleVersion%@ == ",CFBundleVersion);
    
    // Do any additional setup after loading the view.
}
-(void)createTimer{
    _time = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(actionClick) userInfo:nil repeats:YES];
    _time.fireDate = [NSDate distantPast];
    
}
static int flag =60;

-(void)actionClick{
    flag--;
    _loginBack.testButton.text = [NSString stringWithFormat:@"%d",flag];
    _loginBack.testButton.userInteractionEnabled = NO;
    if(flag == 0){
       _loginBack.testButton.text = @"获取验证码";
        flag = 60;
        _loginBack.testButton.userInteractionEnabled = YES;
        _time.fireDate = [NSDate distantFuture];
    }
}
- (void)registerForKeyboardNotifications
{
    //使用NSNotificationCenter 鍵盤出現時
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:)name:UIKeyboardWillShowNotification object:nil];
    //使用NSNotificationCenter 鍵盤隐藏時
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHidden:) name:UIKeyboardWillHideNotification object:nil];
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardDidChangeFrameNotification object:nil];
    
}
- (void)unregNotification{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
-(void)createUI{
    _loginBack = [[LoginBackView alloc]initWithFrame:self.view.bounds];
    //_loginBack.secretTextFile.userInteractionEnabled = NO;
    _keyBoard = [[KeyBoard alloc]initWithFrame:CGRectMake(0, S_H, S_W, 44)];
    _keyBoard.delegate = self;
    _keyBoard.leftButton.hidden = YES;
    _keyBoard.rightButton.hidden = YES;
    __weak typeof(self) weakSelf = self;
    _loginBack.tetBlock = ^(NSInteger n){
        if(n == 1){
            //获取验证码
            [weakSelf sendPwd];
        }else if (n == 2){
            //登录
            if(_loginBack.enterTextFile.text.length == 11){
            if(_loginBack.secretTextFile.text.length == 4){
              [weakSelf loginRequest];
            }else{
                [MBProgressHUD showWithText:@"请输入正确验证码" view:nil];
            }
            }else{
              [MBProgressHUD showWithText:@"请输入正确手机号" view:nil];
            }
        }
    };
    [self.view addSubview:_loginBack];
    _keyView = [[UIView alloc]initWithFrame:CGRectMake(0, S_H, S_W, 44)];
    UIButton * accButton = [[UIButton alloc]init];
    
    [accButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
    }];
    _keyView.backgroundColor = [UIColor blueColor];
    UIButton * canel = [[UIButton alloc]initWithFrame:CGRectMake(20, 40, 30, 30)];
//    canel.backgroundColor = [UIColor blackColor];
    [canel setImage:[UIImage imageNamed:@"shut"] forState:UIControlStateNormal];
    [canel addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:canel];
    //[self.view addSubview:_keyView];
    [self.view addSubview:_keyBoard];
}
-(void)cancel{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//键盘将要显示通知
-(void)keyboardWasShown:(NSNotification*)notification{
    CGRect rect = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    double duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    //self.keyBoardHeight = rect.size.height;
    //NSLog(@"%f",_loginBack.sureView.frame.origin.y+_loginBack.sureView.frame.size.height);
    CGFloat sure = _loginBack.sureView.frame.origin.y+_loginBack.sureView.frame.size.height;
    
    [UIView animateWithDuration:duration animations:^{
        _keyBoard.frame = CGRectMake(0, self.view.frame.size.height - rect.size.height - 44,self.view.frame.size.width, 44);
        _loginBack.frame = CGRectMake(0, (self.view.frame.size.height - rect.size.height - 44 - sure-20), S_W, _loginBack.frame.size.height);
    }];

}
//通知将要隐藏通知
-(void)keyboardWillBeHidden:(NSNotification*)notification{
    double duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        _keyBoard.frame = CGRectMake(0, self.view.frame.size.height,self.view.frame.size.width, 44);
        _loginBack.frame = CGRectMake(0, 0, S_W, _loginBack.frame.size.height);
    }];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [_loginBack.enterTextFile resignFirstResponder];
    [_loginBack.secretTextFile resignFirstResponder];
}
//发送短信
-(void)sendPwd{
    if(_loginBack.enterTextFile.text.length == 11){
        [self createTimer];
        //_loginBack.secretTextFile.userInteractionEnabled = YES;
        NSDictionary * dict = @{@"userid":PHONE_USERID,@"token":PHONE_TOKEN,@"version":PHONE_VERSION ,@"phone":_loginBack.enterTextFile.text};
        [RequestHelp PostRequestWithParameters:dict RequestString:SENDPED Block:^(id datt) {
            if([datt[@"code"] isEqualToString:@"0000"]){
                [MBProgressHUD showWithText:@"发送成功" view:nil];
            }
        }];
    }else{
        [MBProgressHUD showWithText:@"输入正确手机号" view:nil];
    }
    
}
-(void)loginRequest{
    //登录
    if(_loginBack.enterTextFile.text.length == 11){
        [self createTimer];
        NSDictionary * dict = @{@"userid":PHONE_USERID,@"token":PHONE_TOKEN,@"version":PHONE_VERSION ,@"phone":_loginBack.enterTextFile.text,@"smspwd":_loginBack.secretTextFile.text};
        //
        [RequestHelp PostRequestWithParameters:dict RequestString:LOGIN Block:^(id datt) {
            NSLog(@"%@",datt);
            if([datt[@"code"] isEqualToString:@"0000"]){
              [MBProgressHUD showWithText:@"登录成功" view:nil];
                //保存userid 和 token 取消页面
                [Reachability saveToken:datt[@"rt"][@"token"]];
                [Reachability saveUserid:datt[@"rt"][@"id"]];
                [self cancel];
            }
        }];
    }else{
        [MBProgressHUD showWithText:@"登录失败请重试" view:nil];
    }
    
    
}
-(void)dealloc{
    NSLog(@"__func__==%s",__func__);
}
-(void)viewWillDisappear:(BOOL)animated
{
    if(self.delegate && [self.delegate respondsToSelector:@selector(selfViewDissMiss:)]){
        [self.delegate selfViewDissMiss:self.view];
    }
}
-(void)viewDidDisappear:(BOOL)animated
{
    self.isReash = @"吾问无为谓我我我我";
}
#pragma mark - keyboardDelegate
-(void)sureClick:(keyClickType)type
{
    if(type == keySureClickType){
        [_loginBack.enterTextFile resignFirstResponder];
        [_loginBack.secretTextFile resignFirstResponder];
    }else if (type == keyLeftClickType){
        if(_loginBack.secretTextFile.editing){
            [_loginBack.secretTextFile resignFirstResponder];
            [_loginBack.enterTextFile becomeFirstResponder];
        }
    }else if (type == keyRightClickType){
        if(_loginBack.enterTextFile.editing){
            [_loginBack.enterTextFile resignFirstResponder];
            [_loginBack.secretTextFile becomeFirstResponder];
        }
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
