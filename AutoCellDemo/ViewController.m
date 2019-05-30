//
//  ViewController.m
//  AutoCellDemo
//
//  Created by Mac on 2019/5/21.
//  Copyright © 2019年 iMac. All rights reserved.
//

#import "ViewController.h"
#import <Masonry.h>
#import "AutoCell.h"
#import <MJExtension.h>
#import "AutoModel.h"
#import <IQKeyboardManager.h>


@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation ViewController

//- (void)viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:animated];
//    
//    //TODO: 页面appear 禁用
//    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:NO];
//}
//
//- (void)viewWillDisappear:(BOOL)animated {
//    [super viewWillDisappear:animated];
//    
//    //TODO: 页面Disappear 启用
//    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:YES];
//}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    //TODO: 页面appear 禁用
    [IQKeyboardManager sharedManager] .previousNextDisplayMode = IQPreviousNextDisplayModeAlwaysHide;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    //TODO: 页面Disappear 启用
    [IQKeyboardManager sharedManager] .previousNextDisplayMode = IQPreviousNextDisplayModeAlwaysShow;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"这是个标题";
    
    NSArray *modelArray = [NSArray arrayWithObjects:@{@"name":@"张小帅",@"title":@"今天天气不错吧,哈哈"},@{@"name":@"李晓明",@"title":@"滕子铭的眼睛红了,你知不到"},@{@"name":@"王晓刚",@"title":@"已经感到成功的喜悦,好的或多或少;的话"},@{@"name":@"大铁柱",@"title":@"19-05-21 14:29:38.607822+0800 AutoCellDemo[1211:478407] [App] if we're in the real pre-commit handler we can't actually add any new fences due to CA restriction"},@{@"name":@"老丈人",@"title":@" for systemgroup.com.apple.configurationprofiles path is /private/var/containers/Shared/SystemGroup/systemgroup.com.apple"}, nil];
    _dataArray = [AutoModel mj_objectArrayWithKeyValuesArray:modelArray];
    
    NSMutableArray *tempArray = [NSMutableArray array];
    for (int i=0; i<self.dataArray.count; i++) {
        AutoModel *model = self.dataArray[i];
        model.fold = 0;
        [tempArray addObject:model];
    }
    
    _dataArray = tempArray;

    
    [self buildUI];

}

-(void)buildUI{
    _tableView = [UITableView new];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.estimatedRowHeight = 80;
    _tableView.backgroundColor = UIColor.lightGrayColor;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(self.view);
        make.center.equalTo(self.view);
    }];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  
    return self.dataArray.count;
    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AutoCell *cell = [AutoCell cellWithTableView:tableView];
    
    cell.refreshBlock = ^{
        [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    };
    
    AutoModel *mode = self.dataArray[indexPath.row];
    
    cell.model = mode;
    
    return cell;

}

//-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    [self.view endEditing:YES];
//    
//}


@end
