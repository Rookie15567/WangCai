//
//  BaseViewController.m
//  WangCai
//
//  Created by cds on 16/12/1.
//  Copyright © 2016年 cds. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setBackgroundImage:[RGBColor createImageWithColor:[RGBColor colorWithHexString:ALL_ENV_BLUE_COLOR]] forBarMetrics:UIBarMetricsDefault];
   //[self.navigationController.navigationBar setBarTintColor:[RGBColor colorWithHexString:ALL_BLUE_COLOR]];
    UIColor * color = [RGBColor  colorWithHexString:ALL_NAV_TITLE_COLOR];
    UIFont* font;
    if([_font isEqualToString:@"1"]){
        font =TITLE_SELF_FONT(@"Heiti-Bold", 30);
    }else{
    font = TITLE_SELF_FONT(ALL_NAV_TITLE_LIGHT, ALL_NAV_TITLE_FONT);
    }
    NSMutableDictionary *dict=[NSMutableDictionary dictionary];
    [dict setObject:color forKey:NSForegroundColorAttributeName];
    [dict setObject:font forKey:NSFontAttributeName];
    [self.navigationController.navigationBar setTitleTextAttributes:dict];
    UIImageView * bac = [self findHairlineImageViewUnder:self.navigationController.navigationBar];
    bac.hidden = YES;
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[RGBColor colorWithHexString:ALL_ENV_BLUE_COLOR], NSForegroundColorAttributeName,nil] forState:UIControlStateSelected];
//    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    backBtn.frame = CGRectMake(0, 0, 44, 44);
//    
//    [backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
//    [backBtn addTarget:self action:@selector(doBack:) forControlEvents:UIControlEventTouchUpInside];
//    
//    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
//    self.navigationItem.leftBarButtonItem = backItem;
}
- (UIImageView *)findHairlineImageViewUnder:(UIView *)view {
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self findHairlineImageViewUnder:subview];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}
-(void)doBack:(UIButton*)but{
    
}
-(void)setFont:(NSString *)font
{
    _font = font;
    UIColor * color = [RGBColor  colorWithHexString:ALL_NAV_TITLE_COLOR];
    UIFont* fonts;
    if([_font isEqualToString:@"1"]){
        fonts =TITLE_SELF_FONT(@"Helvetica-Bold", ALL_NAV_TITLE_FONT);
    }else{
        fonts = TITLE_SELF_FONT(ALL_NAV_TITLE_LIGHT, ALL_NAV_TITLE_FONT);
    }
    NSMutableDictionary *dict=[NSMutableDictionary dictionary];
    [dict setObject:color forKey:NSForegroundColorAttributeName];
    [dict setObject:fonts forKey:NSFontAttributeName];
    [self.navigationController.navigationBar setTitleTextAttributes:dict];
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
