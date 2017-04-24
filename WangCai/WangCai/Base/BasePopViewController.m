//
//  BasePopViewController.m
//  WangCai
//
//  Created by cds on 16/12/1.
//  Copyright © 2016年 cds. All rights reserved.
//

#import "BasePopViewController.h"

@interface BasePopViewController ()<UINavigationControllerDelegate>

@end

@implementation BasePopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        backBtn.frame = CGRectMake(0, 0, 44, 44);
    UIColor * color = [RGBColor  colorWithHexString:ALL_NAV_TITLE_COLOR];
    UIFont *font = [UIFont fontWithName:ALL_NAV_TITLE_LIGHT
                                   size:ALL_NAV_TITLE_FONT];
    
    NSMutableDictionary *dict=[NSMutableDictionary dictionary];
    [dict setObject:color forKey:NSForegroundColorAttributeName];
    [dict setObject:font forKey:NSFontAttributeName];
    UINavigationBar *bar = [UINavigationBar appearance];
    bar.titleTextAttributes = dict;
        [backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
        [backBtn addTarget:self action:@selector(doBack:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
        self.navigationItem.leftBarButtonItem = backItem;
    // Do any additional setup after loading the view.
}
//点击返回事件
-(void)doBack:(UIButton*)but{
    [self.navigationController popViewControllerAnimated:YES];
}
//自定义push方法

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
