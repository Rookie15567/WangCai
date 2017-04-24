//
//  MyViewController.m
//  WangCai
//
//  Created by cds on 16/12/1.
//  Copyright © 2016年 cds. All rights reserved.
//

#import "MyViewController.h"
#import "MyInfoNavView.h"
#import "MyInfoTableViewCell.h"
#import "LoginXIBViewController.h"
#import "NewsViewController.h"
#import "MeansViewController.h"
#import "KeyBoard.h"
#import "AppKeFuLib.h"
#import "MeansModel.h"
#import "MyApplyForViewController.h"
#import "myInfoSetViewController.h"
#import "GiveLoanViewController.h"
#import "myinfoFootView.h"
@interface MyViewController ()<UITableViewDelegate,UITableViewDataSource,NavViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIAlertViewDelegate,UIAlertViewDelegate,LoginIsReach>
{
    UITableView * _tableView;
    NSArray * _dataSource;
    NSArray * _imgArr;
    NSString * astring;
}
@property(nonatomic,strong)MyInfoNavView * myNavView;
@property (nonatomic,strong)KeyBoard * keyBoard;
@property (nonatomic,strong) myinfoFootView * foot;
@end

@implementation MyViewController
#define NAV_H 124
#define CELL_H 60
- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
    [self customNavBar];
    [self obtainUserInfo];
    // Do any additional setup after loading the view.
}

-(void)createUI{
   // if([Reachability isNeedLogin]){
        _dataSource = @[@"我的申请",@"个人资料",@"在线客服",@"还款提醒",@"邀请好友",@"设置"];
//    }else{
//        _dataSource = @[@"我的申请",@"个人资料",@"在线客服",@"退出登录"];
//    }
    _imgArr = @[@"my_one",@"my_two",@"my_three",@"my_four",@"my_five",@"my_sex"];
    _keyBoard = [[KeyBoard alloc]initWithFrame:CGRectMake(0, S_H, S_W, 44)];
    
    [self createTableView];
}

-(void)createTableView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,NAV_H-68, S_W, S_H-kNavigationBarHeight) style:UITableViewStyleGrouped];
    _tableView.delegate =self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [RGBColor colorWithHexString:LINE_EEEEECOLOR];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView registerClass:[MyInfoTableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:_tableView];
}
-(void)obtainUserInfo{
    NSDictionary * dict = @{@"userid":PHONE_USERID,@"token":PHONE_TOKEN,@"version":PHONE_VERSION};
    //数据请求
    [RequestHelp PostRequestWithParameters:dict RequestString:SYSINFO
                                     Block:^(id datt) {
                                         NSLog(@"%@",datt);
                                         
                                     }];

}
-(void)customNavBar{
    
    _myNavView = [[MyInfoNavView alloc]initWithFrame:CGRectMake(0, -22, S_W, NAV_H)];
    _myNavView.delegate = self;
    _myNavView.newsImageView.hidden = YES;
    UIImage * hImage = [Reachability obtainUserHeadImage:nil];
    if(hImage == nil){
        hImage  = [UIImage imageNamed:@"text"];
    }
    [_myNavView changeHeadVIewImage:hImage];
    _myNavView.isNews = YES;
    _myNavView.typeLabel.hidden = YES;
    if([Reachability isNeedLogin])
    {
        [_myNavView changeHeadVIewImage:[UIImage imageNamed:@"text"]];
        _myNavView.nameLabel.text = @"立即登录";
    }else{
        [self forUsername];
    }
    //[self.navigationController.navigationBar addSubview:_myNavView];
    [self.view addSubview:_myNavView];
    [self.navigationController.navigationBar setHidden:YES];

}
-(void)viewWillAppear:(BOOL)animated
{
    if(!_myNavView){
    _myNavView = [[MyInfoNavView alloc]initWithFrame:CGRectMake(0, -22, S_W, NAV_H)];
    _myNavView.delegate = self;
    _myNavView.isNews = NO;
    //[self.navigationController.navigationBar addSubview:_myNavView];
    [self.view addSubview:_myNavView];
    [self.navigationController.navigationBar setHidden:YES];
   // [self customNavBar];
        [self forUsername];
    }
    if(![Reachability isNeedLogin]){
     [self forUsername];
    }
    [self.navigationController.navigationBar setHidden:YES];
    _myNavView.hidden = NO;
    self.tabBarController.tabBar.hidden = NO;
    [MobClick beginLogPageView:@"my"];
    
}
-(void)forUsername{
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSArray * dict = [user arrayForKey:NSUSER_USER_INFO];
   // NSMutableArray * arr = [NSMutableArray array];
    if(dict != nil || dict.count > 0){
        for (NSDictionary * userdict in dict) {
            MeansModel * moedl = [MeansModel modelWithDictionary:userdict
                                  ];
            if([moedl.title isEqualToString:@"昵称"]){
                if(moedl.detial.length >0){
                    _myNavView.nameLabel.text = moedl.detial;
                }else{
                    _myNavView.nameLabel.text = @"昵称";
                }
            }
        }
    }
}
//-(void)viewDidAppear:(BOOL)animated
//{
//   [self.navigationController.navigationBar setHidden:YES];
//}
-(void)viewWillDisappear:(BOOL)animated
{
    _myNavView.hidden = YES;
    //[_myNavView removeFromSuperview];
    //_myNavView = nil;
    [self.navigationController.navigationBar setHidden:NO];

        [MobClick endLogPageView:@"my"];
    
}

#pragma mark - tableViewDelagate
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyInfoTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setimgImage:_imgArr[indexPath.row] titleString:_dataSource[indexPath.row]];
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSource.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return CELL_H;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([Reachability isNeedLogin]){
        LoginViewController * lvc= [[LoginViewController alloc]init];
        [self presentViewController:lvc animated:YES completion:^{
            
        }];
    }else{
    switch (indexPath.row) {
        case 0:
        {
            MyApplyForViewController * appvc = [[MyApplyForViewController alloc]init];
        
            [self.navigationController pushViewController:appvc animated:YES];
            
            break;
        }
        case 1:
        {
            MeansViewController * mvc= [[MeansViewController alloc]init];
            mvc.hidesBottomBarWhenPushed = YES;
            [self.navigationController.navigationBar setHidden:YES];
            [self.navigationController pushViewController:mvc animated:YES];
            mvc.hidesBottomBarWhenPushed = NO;
             [self.navigationController.navigationBar setHidden:NO];
            break;
        }
        case 2:
        {
            [self APPKEFUController];
            break;
        }
        case 3:
        {
           //
            GiveLoanViewController * mvc = [[GiveLoanViewController alloc]init];
            
            mvc.navTitle = @"还款提醒";
            mvc.hidesBottomBarWhenPushed = YES;
            [self.navigationController.navigationBar setHidden:YES];
            [self.navigationController pushViewController:mvc animated:YES];
            mvc.hidesBottomBarWhenPushed = NO;
            [self.navigationController.navigationBar setHidden:NO];
//            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"" message:@"确定退出登录" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//            [alert show];
            break;
        }
            case 4:
        {
            GiveLoanViewController * mvc = [[GiveLoanViewController alloc]init];
            mvc.hidesBottomBarWhenPushed = YES;
            mvc.navTitle = @"邀请好友";
            [self.navigationController.navigationBar setHidden:YES];
            [self.navigationController pushViewController:mvc animated:YES];
            mvc.hidesBottomBarWhenPushed = NO;
            [self.navigationController.navigationBar setHidden:NO];
//            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"" message:@"确定退出登录" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//            [alert show];
            break;
        }
            case 5:
        {
            __weak typeof(self) weakSelf = self;
            myInfoSetViewController * mvc = [[myInfoSetViewController alloc]init];
            mvc.vcPopBlock = ^(NSInteger a){
                [weakSelf upsdataNav];
            };
            mvc.hidesBottomBarWhenPushed = YES;
            [self.navigationController.navigationBar setHidden:YES];
            [self.navigationController pushViewController:mvc animated:YES];
            mvc.hidesBottomBarWhenPushed = NO;
            [self.navigationController.navigationBar setHidden:NO];
            //            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"" message:@"确定退出登录" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            //            [alert show];
            break;
        }

        default:
            break;
    }
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    _foot = [[myinfoFootView alloc]initWithFrame:CGRectMake(0, 0, S_W, 160)];
    //_foot.backgroundColor = [RGBColor colorWithHexString:TEXT_9999COLOR];
    _foot.label.hidden = YES;
    _foot.qqLabel.hidden = YES;
    return _foot;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 160;
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 0){
        
    }else if (buttonIndex == 1){
        [Reachability leaveLogin];
        [_myNavView changeHeadVIewImage:[UIImage imageNamed:@"text"]];
        _myNavView.nameLabel.text = @"立即登录";
        if([Reachability isNeedLogin]){
            _dataSource = @[@"我的申请",@"个人资料",@"在线客服"];
        }else{
            _dataSource = @[@"我的申请",@"个人资料",@"在线客服",@"退出登录"];
        }
        [_tableView reloadData];
    }
}
-(void)upsdataNav{
    [_myNavView changeHeadVIewImage:[UIImage imageNamed:@"text"]];
    _myNavView.nameLabel.text = @"立即登录";
}
-(void)APPKEFUController{
    //自定义会话页面左上角返回按钮
    UIButton *leftBarButtonItemButton = [[UIButton alloc] initWithFrame:CGRectMake(40, 0, 60, 40)];
    //[leftBarButtonItemButton setTitle:@"返回" forState:UIControlStateNormal];
    [leftBarButtonItemButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [leftBarButtonItemButton addTarget:self action:@selector(leftBarButtonItemTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    
    //自定义会话界面titleView,如果不想自定义,请将对应参数设置为nill
    UILabel *titleView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
    titleView.textColor = [UIColor whiteColor];
    titleView.textAlignment = NSTextAlignmentCenter;
    titleView.text = @"客服小秘书";
    [[AppKeFuLib sharedInstance] pushChatViewController:self.navigationController withWorkgroupName:DEMO_WOKGROUP_ID hideRightBarButtonItem:YES rightBarButtonItemCallback:nil showInputBarSwitchMenu:NO withLeftBarButtonItem:leftBarButtonItemButton withTitleView:titleView withRightBarButtonItem:nil withProductInfo:@"来人了" withLeftBarButtonItemColor:nil hidesBottomBarWhenPushed:TRUE showHistoryMessage:YES defaultRobot:NO mustRate:NO withKefuAvatarImage:IMAGE_NAMED(@"icon") withUserAvatarImage:nil shouldShowGoodsInfo:FALSE withGoodsImageViewURL:nil withGoodsTitleDetail:nil withGoodsPrice:nil withGoodsURL:nil withGoodsCallbackID:nil goodsInfoClickedCallback:nil httpLinkURLClickedCallBack:nil faqButtonTouchUpInsideCallback:nil];
   // [[AppKeFuLib sharedInstance] setTagLanguage:@"汉语"];
    NSLog(@"%@", [AppKeFuLib sharedInstance].getTagLanguage);
}
-(void)leftBarButtonItemTouchUpInside:(UIButton *)sender
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - navDelegate
-(void)navViewOnClickType:(NavClickType)type Str:(NSString *)string
{
    //[_myNavView changeHeadVIewImage:[UIImage imageNamed:@"icon"]];
    if(type == NavNews){
//        NewsViewController * nvc = [[NewsViewController alloc]init];
//        nvc.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:nvc animated:YES];
//        nvc.hidesBottomBarWhenPushed = NO;
    }
    if(type == NavHeadImage){
        //跳转到相机或相册页面
        if([Reachability isNeedLogin]){
            LoginViewController * lvc= [[LoginViewController alloc]init];
            lvc.delegate =self;
            [self presentViewController:lvc animated:YES completion:^{
                
            }];
        }else{
            astring = string;
            [self UesrImageClicked];
        }
       
    }
    if(type == NavName){
        if([Reachability isNeedLogin]){
            LoginViewController * lvc= [[LoginViewController alloc]init];
            lvc.delegate =self;
            [self presentViewController:lvc animated:YES completion:^{
                
            }];
        }
    }
}
- (void)UesrImageClicked
{
    UIActionSheet *sheet;
    // 判断是否支持相机
    if([UIImagePickerController
        isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        sheet  = [[UIActionSheet alloc] initWithTitle:@"选择图像" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"拍照",@"从相册选择",nil];
    }
    else
    {
        sheet = [[UIActionSheet alloc] initWithTitle:@"选择图像" delegate: self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"从相册选择", nil];
    }
    sheet.tag = 255;
    
    [sheet showInView:self.view];
}
#pragma mark - action sheet delegte
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == 255) {
        NSUInteger sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        if([UIImagePickerController
            isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {             switch (buttonIndex) {
            case 0:
                return;
            case 1: //相机
                sourceType = UIImagePickerControllerSourceTypeCamera;                     break;
            case 2: //相册
                sourceType = UIImagePickerControllerSourceTypePhotoLibrary;                     break;
        }
        }
        else
        {
            if (buttonIndex == 0){
                return;
            } else {
                @try {
                    
                } @catch (NSException *exception) {
                    
                } @finally {
                    
                }
                sourceType =
                UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            }
        }
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.delegate = self;
        imagePickerController.allowsEditing = YES;
        imagePickerController.sourceType = sourceType;
        [self presentViewController:imagePickerController animated:YES completion:^{}];
    }
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    // NSLog(@"%@",info[UIImagePickerControllerEditedImage]);
    [picker dismissViewControllerAnimated:YES completion:nil];
    //_myNavView.headImageView.image =info[UIImagePickerControllerEditedImage];
    UIImage * iamge =info[UIImagePickerControllerEditedImage];
    [_myNavView changeHeadVIewImage:iamge];
    //上传图片 
    [Reachability saveDiskSandBy:nil image:iamge];
    NSString * name ;
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSArray * arr = [user arrayForKey:NSUSER_USER_INFO];
    for(int i=0;i<arr.count;i++){
        MeansModel * model = arr[i];
        if([model.title isEqualToString:@"昵称"]){
            name = model.detial;
        }
    }
    [RequestHelp uploadUserHeadImage:iamge Name:name Block:^(id datt) {
        NSLog(@"%@",datt);
    }];
    //[_headView setbackImage:info[UIImagePickerControllerEditedImage]];
}
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    // NSLog(@"%@",picker);
    [picker dismissViewControllerAnimated:YES completion:nil];
}
-(void)selfViewDissMiss:(UIView *)view{
    
//    if([Reachability isNeedLogin]){
//        _dataSource = @[@"我的申请",@"个人资料",@"在线客服"];
//    }else{
//        _dataSource = @[@"我的申请",@"个人资料",@"在线客服",@"退出登录"];
//    }
  //  [_tableView reloadData];
    [self  customNavBar];
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
