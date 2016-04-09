//
//  ViewController.m
//  智联下拉
//
//  Created by James on 16/4/8.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "ViewController.h"
#import "BezierView.h"
#import "UIView+Frame.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>
@property(weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet BezierView *bezierView;


@end

@implementation ViewController {
  NSArray *_arr;
}
static NSString *ID = @"cellID";

- (void)viewDidLoad {
  [super viewDidLoad];
  //当viewController + navigationController 会导致tableView下移,需要使用这段话关闭自动调整
  self.automaticallyAdjustsScrollViewInsets = NO;

  [self prepareData];

  [self preparetableView];
}
- (void)preparetableView {

  self.tableView.dataSource = self;
  self.tableView.delegate = self;

  [self.tableView registerClass:[UITableViewCell class]
         forCellReuseIdentifier:ID];
}

- (void)prepareData {
  NSMutableArray *arrM = [NSMutableArray array];

  for (int i = 0; i < 100; ++i) {
    [arrM addObject:@(i)];
  }

  _arr = arrM.copy;
}

#pragma mark - UITableViewDelegate, UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
  return _arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {

  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];

  cell.textLabel.text = [NSString stringWithFormat:@"%@", _arr[indexPath.row]];

  return cell;
}

#pragma mark - scrollView代理方法

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

    //偏移量
    CGFloat offsetY = scrollView.contentOffset.y;
    
    NSLog(@"%f",offsetY);
    
    if (offsetY <= 0) {

        _bezierView.offsetY = offsetY;
    }else {
        _bezierView.y = 64 -offsetY;
        
    }
    
}
@end
