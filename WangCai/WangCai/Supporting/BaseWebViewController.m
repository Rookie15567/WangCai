//
//  BaseWebViewController.m
//  WangCai
//
//  Created by cds on 16/12/28.
//  Copyright © 2016年 cds. All rights reserved.
//

#import "BaseWebViewController.h"
#import "LoanMainCellModel.h"
@interface BaseWebViewController ()<UIWebViewDelegate,UIAlertViewDelegate>
@property (nonatomic,strong)UIWebView * webView;
@property (nonatomic,strong)MBProgressHUD * hud;
@end

@implementation BaseWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.navigationController.navigationBarHidden = YES;
    self.tabBarController.tabBar.hidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    _webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
    _webView.delegate = self;
    
    if([_baseUrl isEqualToString:@"aldb.me/4gCOE"])
    {
        _baseUrl = @"https://m.aladingbank.com/web_act/src/webApp/page/bigWaspRegister/main.html?ch=jiehuahua2";
        
    }
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_baseUrl]]];
    
    UIView* iew = [UIApplication sharedApplication].keyWindow;

    _hud = [MBProgressHUD showHUDAddedTo:iew animated:YES];
    [RequestHelp GETquestWithUrl:_baseUrl Block:^(id datt) {
        NSLog(@"datt == %@",datt);
         //[_hud hideAnimated:YES];
       // [_webView loadHTMLString:datt baseURL:nil];
    }];
    [self.view addSubview:_webView];
    // Do any additional setup after loading the view.
}
-(void)webViewDidStartLoad:(UIWebView *)webView
{
    
}
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [_hud hideAnimated:YES];
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [_hud hideAnimated:YES];
}
-(void)doBack:(UIButton *)but
{
    if(_isDetail == YES){
        UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"是否已完成申请" message:@"" delegate:self cancelButtonTitle:@"只是看看" otherButtonTitles:@"已申请", nil];
        [alertView show];
    }else{
            self.navigationController.navigationBarHidden = NO;
            [self.navigationController popViewControllerAnimated:YES];
            self.tabBarController.tabBar.hidden = YES;
    }
    

}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 0){
        //只是看看 不保存
    }else if (buttonIndex == 1){
       // [RequestHelp userLoanSucceedmnum:_mnum rmbNum:_rmbnum pid:_buffDict[@"id"]];
        //保存
        BOOL isSave = NO;
        NSLog(@"%@",NSHomeDirectory());
        NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
        NSMutableArray * dataSource = [NSMutableArray arrayWithArray:[user valueForKey:DISK_USER_APPLR]];
        if(dataSource.count == 0){
            dataSource = [NSMutableArray array];
            [dataSource addObject:_buffDict];
            // [user setObject:_buffDict forKey:DISK_USER_APPLR];
        }else{
            
        }
        for (int i=0;i<dataSource.count;i++){
            LoanMainCellModel * model = [LoanMainCellModel modelWithDictionary:dataSource[i]];
            if([model.id isEqualToString:_buffDict[@"id"]]){
                isSave = NO;
                break;
            }else{
                isSave = YES;
            }
        }
        if(isSave){
        [dataSource addObject:_buffDict];
        }
        NSLog(@"%@ == _buffDict%@",dataSource,_buffDict);
        [user setObject:dataSource forKey:DISK_USER_APPLR];
        
        [user synchronize];
    }
        self.navigationController.navigationBarHidden = NO;
        [self.navigationController popViewControllerAnimated:YES];
        self.tabBarController.tabBar.hidden = YES;
    NSLog(@"%ld",(long)buttonIndex);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
