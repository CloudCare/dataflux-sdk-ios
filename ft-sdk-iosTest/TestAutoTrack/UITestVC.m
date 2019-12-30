//
//  UITestVC.m
//  ft-sdk-iosTest
//
//  Created by 胡蕾蕾 on 2019/12/20.
//  Copyright © 2019 hll. All rights reserved.
//

#import "UITestVC.h"
#import "UITestManger.h"
@interface UITestVC ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation UITestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [[UITestManger sharedManger] addAutoTrackViewScreenCount];

    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self createUI];
}
-(void)createUI{
    self.title = @"testUI";
    CGFloat x = 16;
    CGFloat y = 16;
    CGFloat width = self.view.frame.size.width - 2 * x;

    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)/2)];
    _scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:_scrollView];

    _firstButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _firstButton.frame = CGRectMake(x, y, width, 44);
    [_firstButton setTitle:@"FirstButton" forState:UIControlStateNormal];
    [_firstButton setTitle:@"SelectedFirstButton" forState:UIControlStateSelected];
    [_firstButton addTarget:self action:@selector(firstAction:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:_firstButton];

    y = CGRectGetMaxY(_firstButton.frame) + 16;
    _secondButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _secondButton.frame = CGRectMake(x, y, width, 44);
    [_secondButton setTitle:@"SecondButton" forState:UIControlStateNormal];
    [_secondButton setTitle:@"SelectedSecondButton" forState:UIControlStateSelected];
    [_secondButton addTarget:self action:@selector(secondAction:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:_secondButton];

    y = CGRectGetMaxY(_secondButton.frame) + 16;
    _stepper = [[UIStepper alloc] initWithFrame:CGRectMake(x, y, 80, 40)];
    [_stepper addTarget:self action:@selector(stepperAction:) forControlEvents:UIControlEventValueChanged];
    [_scrollView addSubview:_stepper];

 

    _uiswitch = [[UISwitch alloc] init];
    _uiswitch.frame = CGRectMake(CGRectGetMaxX(_stepper.frame)+50, y, 80, 40);
    [_uiswitch addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
    [_scrollView addSubview:_uiswitch];

    _segmentedControl.frame = CGRectMake(100, 100, 100, 40);
    _segmentedControl.backgroundColor = [UIColor blueColor];
    _segmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"first", @"second", @"third"]];
    [_segmentedControl addTarget:self action:@selector(segmentedAction:) forControlEvents:UIControlEventValueChanged];
    [_scrollView addSubview:_segmentedControl];

    y = CGRectGetMaxY(_uiswitch.frame) + 20;
    _label = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, 50)];
    _label.textAlignment = NSTextAlignmentCenter;
    _label.backgroundColor = [UIColor orangeColor];
    _label.text = @"lable";
    _label.userInteractionEnabled = YES;
    [_scrollView addSubview:_label];

    y = CGRectGetMaxY(_label.frame) + 10;
    _imageView = [[UIImageView alloc] init];
    _imageView.userInteractionEnabled = YES;
    _imageView.frame = CGRectMake(x, y, width, 50);
    _imageView.backgroundColor = [UIColor lightGrayColor];
    _imageView.image = [UIImage imageNamed:@"order_status_top"];
    [_scrollView addSubview:_imageView];

    _scrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(_imageView.frame) + 16);

    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap1Action:)];
    [_label addGestureRecognizer:tap1];

    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap2Action:)];
    [_imageView addGestureRecognizer:tap2];

    [self setupTableView];
    
    
}
- (void)setupTableView {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_scrollView.frame), CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)/2)];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];

    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
}

- (void)firstAction:(UIButton *)sender {
    NSLog(@"%@ Touch Up Inside", sender.currentTitle);
    [[UITestManger sharedManger] addAutoTrackClickCount];

}

- (void)secondAction:(UIButton *)sender {
    NSLog(@"%@ Touch Up Inside", sender.currentTitle);
    [[UITestManger sharedManger] addAutoTrackClickCount];

}
- (void)stepperAction:(UIStepper *)sender {
    NSLog(@"UIStepper on:%f", sender.value);
    [[UITestManger sharedManger] addAutoTrackClickCount];

}

- (void)switchAction:(UISwitch *)sender {
    NSLog(@"UISwitch on:%d", sender.isOn);
    [[UITestManger sharedManger] addAutoTrackClickCount];

}

- (void)segmentedAction:(UISegmentedControl *)sender {
    NSLog(@"UISwitch on:%ld", sender.selectedSegmentIndex);
    [[UITestManger sharedManger] addAutoTrackClickCount];

}

- (void)labelTouchUpInside:(UITapGestureRecognizer *)recognizer {
    UILabel *label = (UILabel *)recognizer.view;
    NSLog(@"%@被点击了", label.text);
    [[UITestManger sharedManger] addAutoTrackClickCount];

}
- (void)tap1Action:(UIGestureRecognizer *)sender {
    UILabel *label = (UILabel *)sender.view;
    NSLog(@"%@被点击了", label.text);
   
    [[UITestManger sharedManger] addAutoTrackClickCount];

}

- (void)tap2Action:(UIGestureRecognizer *)sender {
    NSLog(@"UIImageView被点击了");
    [[UITestManger sharedManger] addAutoTrackClickCount];
}
#pragma mark -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"Section: %ld, Row: %ld", indexPath.section, indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%@", indexPath);
    [[UITestManger sharedManger] addAutoTrackClickCount];

}
-(void)dealloc{
   
    [[UITestManger sharedManger] addAutoTrackViewScreenCount];

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
