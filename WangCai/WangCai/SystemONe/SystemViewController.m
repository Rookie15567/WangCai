//
//  SystemViewController.m
//  WangCai
//
//  Created by cds on 17/1/8.
//  Copyright © 2017年 cds. All rights reserved.
//

#import "SystemViewController.h"
#import "headView.h"
#import "ScrollHeadView.h"
#import "NewsTableViewCell.h"
#import "NewsModel.h"
@interface SystemViewController ()<UITableViewDelegate,UITableViewDataSource,ScrollViewDelegate>
{
    UITableView * _tableView;
    NSMutableArray * _dataSource;
    
}
@property (nonatomic,strong)ScrollHeadView * headView;
@end

@implementation SystemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"51旺财";
    self.font = @"1";//设置字体
    [self createUI];
    [self createDataSource];
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(100, 100, 20, 80)];
    imageView.backgroundColor = [UIColor yellowColor];
    [self.navigationItem.titleView addSubview:imageView];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
}
//创建数据
-(void)createDataSource{
    _dataSource = [NSMutableArray array];
    NSString * path = [[NSBundle mainBundle]pathForResource:@"messageList" ofType:@"plist"];
    NSDictionary * data = [[NSDictionary alloc]initWithContentsOfFile:path];
    //NSLog(@"%@",data);
    for(int i=0;i<[data[@"data"][@"net"] count];i++){
        
        NewsModel * model = [NewsModel modelWithDictionary:data[@"data"][@"net"][i]];
        [_dataSource addObject:model];
    }
    for(int i=0;i<[data[@"data"][@"card"] count];i++){
        
        NewsModel * model = [NewsModel modelWithDictionary:data[@"data"][@"card"][i]];
        [_dataSource addObject:model];
    }
}

-(void)createUI{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, S_W, S_H-64) style:UITableViewStylePlain];
    _tableView.delegate =self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView registerClass:[NewsTableViewCell class] forCellReuseIdentifier:@"cell"];
    
    _headView= [[ScrollHeadView alloc]initWithFrame:CGRectMake(0, 0, S_W, 120)];
    _tableView.tableHeaderView = _headView;
    _headView.pageControlPosition = PageControlPositionCenter;
    _headView.imageUrls = @[@"00-1.jpg",@"000-2.jpg"];
    _headView.timeInterval = 2;
    _headView.noUrl = @"1";
     __weak typeof(self) weakself = self;
    _headView.bannerItemClick = ^(NSInteger f){
        [weakself pushwebView:f];
    };
    _headView.delegate = self;
    [self.view addSubview:_tableView];
}
-(void)pushwebView:(NSInteger)k{
    NSArray * urlArr = @[@"http://money.sohu.com/20161224/n476798848.shtml",@"http://www.haodai.com/zixun/146854.html"];
    BaseWebViewController * bvc = [[BaseWebViewController alloc]init];
    bvc.baseUrl = urlArr[k];
    [self.navigationController pushViewController:bvc animated:YES];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewsTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NewsModel * model = _dataSource[indexPath.row];
    [cell setData:model];
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSource.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BaseWebViewController * webv = [[BaseWebViewController alloc]init];
    NewsModel * mdoel = _dataSource[indexPath.row];
    webv.baseUrl = mdoel.url;
    // webv.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:webv animated:YES];
    
}
-(void)bannerScrollView:(ScrollHeadView *)bannerScrollView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"%d",index);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/**设置imageUrls 数据 和占位图片 及广告点击回调 更适和展示网络图片***/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
