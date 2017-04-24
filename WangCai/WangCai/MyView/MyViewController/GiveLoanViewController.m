//
//  GiveLoanViewController.m
//  WangCai
//
//  Created by cds on 17/3/17.
//  Copyright © 2017年 cds. All rights reserved.
//

#import "GiveLoanViewController.h"

@interface GiveLoanViewController ()

@end

@implementation GiveLoanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = _navTitle;
    self.view.backgroundColor = [UIColor whiteColor];
    [self createUI];
    // Do any additional setup after loading the view.
}
-(void)createUI{
    UIImageView * imageaView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 30, 180*K_S_W, 150*K_S_W)];
    imageaView.center = CGPointMake(S_W/2, imageaView.center.y);
    imageaView.image = [UIImage imageNamed:@"My_infomation"];
    [self.view addSubview:imageaView];
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
