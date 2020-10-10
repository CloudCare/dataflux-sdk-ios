//
//  TestANRVC.m
//  SampleApp
//
//  Created by 胡蕾蕾 on 2020/10/10.
//  Copyright © 2020 hll. All rights reserved.
//

#import "TestANRVC.h"

@interface TestANRVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *myTableView;
@end

@implementation TestANRVC


- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        self.view.backgroundColor = [UIColor blueColor];
//    });
    [self.view addSubview:self.myTableView];
}

- (UITableView *)myTableView
{
    if(!_myTableView) {
        _myTableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
    }
    return _myTableView;
}

#pragma mark - tableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify =@"cellIdentify";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if(!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identify];
    }
    if (indexPath.row % 10 == 0) {
        usleep(1 * 1000 * 1000); // 1秒
        cell.textLabel.text = @"卡咯";
    }else{
        cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    }
    
    return cell;
}

@end
