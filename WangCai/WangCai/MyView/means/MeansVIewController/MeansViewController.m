//
//  MeansViewController.m
//  WangCai
//
//  Created by cds on 16/12/6.
//  Copyright © 2016年 cds. All rights reserved.
//

#import "MeansViewController.h"
#import "MeansTableViewCell.h"
#import "MeansModel.h"
#import "KeyBoard.h"
#import "DQconstellationView.h"
#import <MJExtension.h>
#define kMaxLength 11
#define usercardlength 18 //身份证号长度
@interface MeansViewController ()<UITableViewDelegate,UITableViewDataSource,MeansDelagate,DQconstellationViewDelegate,keyBoardDelegate>
{
    UITableView * _tableView;
    NSMutableArray * _dataSource;
    NSMutableArray * _BuffArr;
    UITextField * _textfile;//临时
    NSString * _BuffTitle;
    NSIndexPath * lastIndexPath;//上次选中标记
    NSInteger lastIndexPathRow;
}
@property (nonatomic,strong)KeyBoard * keyBoard;
@property (nonatomic,strong)DQconstellationView * DQconstellationView;
@property (nonatomic,strong)DQconstellationView * DQconstellationViewone;
@property (nonatomic,strong)MeansTableViewCell * buffCell;
@end

@implementation MeansViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataSource = [NSMutableArray array];
    
    [self createDataSource];
    [self createTableView];
    [self createPickView:nil];
    [self registerForKeyboardNotifications];
    // Do any additional setup after loading the view.
}
-(void)createPickView:(NSArray*)array{
    self.DQconstellationView = [DQconstellationView new];
    self.DQconstellationView.delegate = self;
    self.DQconstellationViewone= [DQconstellationView new];
    self.DQconstellationViewone.delegate = self;
    _DQconstellationView.SourceArray = @[@"小学",@"初中",@"高中/职高/技校",@"大专",@"本科",@"硕士",@"博士"];
    _DQconstellationViewone.SourceArray = @[@"未婚",@"已婚"];
}
-(void)createDataSource{
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSArray * dict = [user arrayForKey:NSUSER_USER_INFO];
    if(!dict){
        NSArray * arr  = @[@"姓名",@"昵称",@"手机号"];
        NSArray * plArr = @[@"请输入真实姓名",@"请输入您的昵称",@"手机号"];
        NSMutableArray * marr = [NSMutableArray array];
        for(int i=0;i<arr.count;i++){
            NSString * typeStr = @"1"; //1 位可编辑 2不可编辑 3pick
            if([arr[i] isEqualToString:@"婚姻状况"] || [arr[i] isEqualToString:@"文化程度"]){
                typeStr = @"3";
            }else{
                typeStr = @"1";
            }
            NSDictionary * dicc = @{@"type":typeStr,@"title":arr[i],@"detial":@"",@"plString":plArr[i]};
            MeansModel * moedl = [MeansModel modelWithDictionary:dicc];
            [_dataSource addObject:moedl];
            [marr addObject:dicc];
        }
        NSArray * userarr = [NSArray arrayWithArray:marr];
        [user setObject:userarr forKey:NSUSER_USER_INFO];
        [user synchronize];
    }else{
        _BuffArr = [NSMutableArray arrayWithArray:dict];//dict;
        for (NSDictionary * userdict in dict) {
            MeansModel * moedl = [MeansModel modelWithDictionary:userdict
                                  ];
            [_dataSource addObject:moedl];
        }
    }
    
    
}
#pragma mark - 键盘
- (void)registerForKeyboardNotifications
{
    //使用NSNotificationCenter 鍵盤出現時
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardMeansWasShown:)name:UIKeyboardWillShowNotification object:nil];
    //使用NSNotificationCenter 鍵盤隐藏時
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardMeansWillBeHidden:) name:UIKeyboardWillHideNotification object:nil];
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardDidChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFiledEditChanged:)name:UITextFieldTextDidChangeNotification object:nil];
}
-(void)createTableView{
    _keyBoard = [[KeyBoard alloc]initWithFrame:CGRectMake(0, S_H, S_W, 44)];
    _keyBoard.delegate = self;
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, S_W, S_H) style:UITableViewStyleGrouped];
    _tableView.backgroundColor = [RGBColor colorWithHexString:LINE_EEEEECOLOR];
    _tableView.translatesAutoresizingMaskIntoConstraints = NO;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView registerClass:[MeansTableViewCell class] forCellReuseIdentifier:@"cell"];
    
    [self.view addSubview:_tableView];
    [self.view addSubview:_keyBoard];
}
#pragma mark - tableViewdelegate
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MeansTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.delegate = self;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    MeansModel * model = _dataSource[indexPath.row];
    cell.model = model;
    cell.NowIndex = indexPath.row;
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSource.count;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, S_W, 40)];
    view.backgroundColor = [UIColor whiteColor];
    UILabel * label = [[UILabel alloc]initWithFrame:view.bounds];
    label.text = @"加密处理";
    label.font = [UIFont fontWithName:ALL_NAV_TITLE_LIGHT size:12];
    label.textColor = [RGBColor colorWithHexString:@"999999"];
    label.textAlignment = NSTextAlignmentCenter;
    
    [view addSubview:label];
    UIImageView * line = [UIImageView new];
    line.backgroundColor = [RGBColor colorWithHexString:LINE_EEEEECOLOR];
    
    [view addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(S_W);
        make.height.mas_equalTo(1);
        make.left.equalTo(view.mas_left).with.offset(0);
        make.bottom.equalTo(view.mas_bottom).with.offset(0);
    }];
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *fvc= [[UIView alloc]initWithFrame:CGRectMake(0, 0, S_W, 100)];
    UIView * butView = [UIView new];
    butView.backgroundColor = [RGBColor colorWithHexString:ALL_ENV_BLUE_COLOR];
    butView.userInteractionEnabled = YES;
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(saveClick)];
    [butView addGestureRecognizer:tap];
    [fvc addSubview:butView];
    [butView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(25, 48, 25, 48));
    }];
    UILabel * lab = [UILabel new];
    lab.textColor = [UIColor whiteColor];
    lab.textAlignment = NSTextAlignmentCenter;
    lab.text = @"保存";
    UITapGestureRecognizer * saveTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(saveUserInfo)];
    
    [butView addGestureRecognizer:saveTap];
    [butView addSubview:lab];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
       make.edges.mas_equalTo(UIEdgeInsetsMake(0,0,0,0));
    }];
    return fvc;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 100;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(indexPath.row<4){
        lastIndexPath = indexPath;
        lastIndexPathRow = indexPath.row;
    _buffCell = [_tableView cellForRowAtIndexPath:indexPath];
    [_buffCell.enterTextFile becomeFirstResponder];
    }else if (indexPath.row == 4|| indexPath.row == 5){
        _buffCell = [_tableView cellForRowAtIndexPath:lastIndexPath];
        [_buffCell.enterTextFile resignFirstResponder];
        
        _buffCell = [_tableView cellForRowAtIndexPath:indexPath];
        [self tapOnClick:indexPath.row];
    }
    //制作Model
    MeansModel * model = _dataSource[indexPath.row];
    _BuffTitle = model.title;
    _keyBoard.contentString = model.plString;
    NSLog(@"%@",model.plString);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)keyboardMeansWasShown:(NSNotification*)notification{
    CGRect rect = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    double duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGFloat sure = [_textfile superview].frame.origin.y + [_textfile superview].frame.size.height;
    CGFloat lenth = 0;
    if(sure-20 >self.view.frame.size.height - rect.size.height - 44){
        lenth =self.view.frame.size.height - rect.size.height - 44 -sure-20;
    }
    NSLog(@"sure == %f",[_textfile superview].frame.origin.y);
    [UIView animateWithDuration:duration animations:^{
        _keyBoard.frame = CGRectMake(0, self.view.frame.size.height - rect.size.height - 44,self.view.frame.size.width, 44);
        _tableView.frame = CGRectMake(0, lenth, S_W, _tableView.frame.size.height);
    }];
    
}

-(void)keyboardMeansWillBeHidden:(NSNotification*)notification{
    double duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        _keyBoard.frame = CGRectMake(0, self.view.frame.size.height,self.view.frame.size.width, 44);
        _tableView.frame = CGRectMake(0, 0, S_W, _tableView.frame.size.height);
        //_loginBack.frame = CGRectMake(0, 0, S_W, _loginBack.frame.size.height);
    }];
}
#pragma mark - 保存
-(void)saveUserInfo{
    NSLog(@"%@",_dataSource);
    [_textfile resignFirstResponder];
    NSString * name;
    for(int i=0;i<_dataSource.count;i++){
        MeansModel * model = _dataSource[i];
        NSLog(@"title=%@--type=%@--plString=%@--detial=%@",model.title,model.type,model.plString,model.detial);
        if([model.title isEqualToString:@"昵称"]){
            if(model.detial.length>0){
                //上传
                name = model.detial;
            }
            name = model.detial;
        }
    }
  UIImage * image = [Reachability obtainUserHeadImage:nil];
    if(!image){
        image = [UIImage imageNamed:@"test"];
    }
    [RequestHelp uploadUserHeadImage:image Name:name Block:^(id datt) {
        NSLog(@"%@",datt);
    }];
    
    NSArray * array = [MeansModel mj_keyValuesArrayWithObjectArray:_dataSource];
    
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSArray * userarr = [NSArray arrayWithArray:array];
    [user setObject:userarr forKey:NSUSER_USER_INFO];
    [user synchronize];
    [MBProgressHUD showWithText:@"保存成功" view:nil];
}
-(void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = NO;
    [MobClick beginLogPageView:@"myInfo"];
}


#pragma mark - meansDelagate
-(void)textFIleBegin:(UITextField *)tf
{
    if(_textfile){
        _textfile = nil;
    }
    _textfile = tf;
    for(int i=0;i<_dataSource.count;i++){
        MeansTableViewCell * cell = [_tableView visibleCells][i];
        if(cell.enterTextFile == _textfile){
            lastIndexPathRow = i;
        }
    }
    
  // NSLog(@"tag === %ld",lastIndexPathRow);
}
-(void)textFileEndSelectCellTitle:(NSString *)title contentStr:(NSString *)contenStr Dict:(NSDictionary *)dic
{
    for(int  i=0;i<_BuffArr.count;i++){
        if([_BuffArr[i][@"title"] isEqualToString:title])
        {
            [_BuffArr replaceObjectAtIndex:i withObject:dic];
            break;
        }
    }
   // NSLog(@"buff == %@",_BuffArr);
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [_textfile resignFirstResponder];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [_textfile resignFirstResponder];
}
- (void)unregNotification{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [self unregNotification];
     [MobClick endLogPageView:@"myInfo"];
}
-(void)saveClick{
    NSLog(@"%@",_BuffArr);
}
#pragma mark - pickVIew
-(void)clickDQconstellationEnsureBtnActionConstellationStr:(NSString *)str
{
    _buffCell.plString = str;
    _buffCell.textcolor = [RGBColor colorWithHexString:TEXT_BLACKCOLOR];
    _buffCell.model.detial = str;
    NSDictionary * dic = [_buffCell.model modelToJSONObject];
    for(int  i=0;i<_BuffArr.count;i++){
        if([_BuffArr[i][@"title"] isEqualToString:_BuffTitle])
        {
            [_BuffArr replaceObjectAtIndex:i withObject:dic];
            break;
        }
    }
}
-(void)tapOnClick:(NSInteger)k{
   
    if(k ==4){
    [self.DQconstellationView startAnimationFunction];
    }else if (k==5){
    [self.DQconstellationViewone startAnimationFunction];
    }
}
#pragma mark - 键盘点击事件

-(void)sureClick:(keyClickType)type
{
    if(type == keySureClickType){
        [_textfile resignFirstResponder];
    }else if (type == keyLeftClickType){
   //键盘跳转按键
            NSIndexPath * path = [NSIndexPath indexPathForRow:--lastIndexPathRow inSection:lastIndexPath.section];
            _buffCell = [_tableView cellForRowAtIndexPath:path];
            [_buffCell.enterTextFile becomeFirstResponder];
            if(lastIndexPathRow <0){
                lastIndexPathRow = 0;
            }
//限制超出
        
        
    }else if (type == keyRightClickType){
        if(lastIndexPathRow >= 2){
            lastIndexPathRow = 2;
        }else{
            NSIndexPath * path = [NSIndexPath indexPathForRow:++lastIndexPathRow inSection:lastIndexPath.section];
            _buffCell = [_tableView cellForRowAtIndexPath:path];
            [_buffCell.enterTextFile becomeFirstResponder];
            
        }
        
    }
    MeansModel * model = _dataSource[lastIndexPathRow];
    _keyBoard.contentString = model.plString;
}

-(void)textFiledEditChanged:(NSNotification *)obj{
    UITextField *textField = (UITextField *)obj.object;
    CGFloat length = 0;
    NSLog(@"%@",textField.placeholder);
    if(lastIndexPathRow == 2){
        length = kMaxLength;
    }else if ([textField.placeholder isEqualToString:@"请输入真实身份证号码"]){
        length = usercardlength;
    }else{
        length = 6;
    }
    NSString *toBeString = textField.text;
    NSString *lang = [[UITextInputMode currentInputMode] primaryLanguage]; // 键盘输入模式
    if ([lang isEqualToString:@"zh-Hans"]) { // 简体中文输入，包括简体拼音，健体五笔，简体手写
        UITextRange *selectedRange = [textField markedTextRange];       //获取高亮部分
        UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position) {
            if (toBeString.length > length) {
                textField.text = [toBeString substringToIndex:length];
            }
        }       // 有高亮选择的字符串，则暂不对文字进行统计和限制
        else{
        }
    }   // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
    else{
     if (toBeString.length > length) {
        textField.text = [toBeString substringToIndex:length];
        }
    }
}
-(void)dealloc{
    NSLog(@"__func__==%s",__func__);
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
