//
//  myInfoSetViewController.m
//  WangCai
//
//  Created by cds on 17/3/17.
//  Copyright © 2017年 cds. All rights reserved.
//

#import "myInfoSetViewController.h"
#import "MyInfoTableViewCell.h"
@interface myInfoSetViewController ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>
{
    UITableView * _tableView;
    NSArray * _dataSource;
    NSArray * _imgArr;
    NSString * astring;
}
@end
#define CELL_H 60
@implementation myInfoSetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"设置";
    [self createUI];
    // Do any additional setup after loading the view.
}
-(void)createUI{
    // if([Reachability isNeedLogin]){
    _dataSource = @[@"退出登录"];
    //    }else{
    //        _dataSource = @[@"我的申请",@"个人资料",@"在线客服",@"退出登录"];
    //    }
    _imgArr = @[@"my_back"];
  
    [self createTableView];
}

-(void)createTableView{
    self.view.translatesAutoresizingMaskIntoConstraints = NO;
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0, S_W, S_H-kNavigationBarHeight) style:UITableViewStyleGrouped];
    _tableView.delegate =self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [RGBColor colorWithHexString:LINE_EEEEECOLOR];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView registerClass:[MyInfoTableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:_tableView];
}
#pragma mark - tableViewDelagate
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyInfoTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setimgImage:_imgArr[indexPath.row] titleString:_dataSource[indexPath.row]];
    cell.titleLabel.textColor = [UIColor redColor];
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
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //退出登录
                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"" message:@"确定退出登录" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                [alert show];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 0){
        
    }else if (buttonIndex == 1){
        [Reachability leaveLogin];
        [self.navigationController popViewControllerAnimated:YES];
        if(self.vcPopBlock){
            _vcPopBlock(1);
        }
//        [_myNavView changeHeadVIewImage:[UIImage imageNamed:@"text"]];
//        _myNavView.nameLabel.text = @"立即登录";
//        if([Reachability isNeedLogin]){
//            _dataSource = @[@"我的申请",@"个人资料",@"在线客服"];
//        }else{
//            _dataSource = @[@"我的申请",@"个人资料",@"在线客服",@"退出登录"];
//        }
       // [_tableView reloadData];
    }
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
