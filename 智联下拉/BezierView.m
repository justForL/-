//
//  BezierView.m
//  智联下拉
//
//  Created by James on 16/4/8.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "BezierView.h"

@interface BezierView ()

@end

@implementation BezierView {
  UIImageView *_iconView;
  CGPoint _point;
}

- (void)awakeFromNib {
    self.backgroundColor = [UIColor colorWithRed:255 green:0 blue:0 alpha:1];
    
}

- (void)drawRect:(CGRect)rect {

  _point = CGPointMake(self.bounds.size.width * 0.5,
                       self.bounds.size.height * 0.5 - self.offsetY / 1.5);

  [self prepareIconView];
    
  [[UIColor whiteColor] set];

  UIBezierPath *path = [UIBezierPath bezierPath];

  [path moveToPoint:CGPointMake(0, self.bounds.size.height)];

  [path addLineToPoint:_point];

  [path addLineToPoint:CGPointMake(self.bounds.size.width,
                                   self.bounds.size.height)];

  [path setLineWidth:20];

  [path setLineCapStyle:kCGLineCapRound];
  [path setLineJoinStyle:kCGLineJoinRound];

  [path fill];
}

- (void)prepareIconView {

    if (_iconView == nil) {
        _iconView = [[UIImageView alloc] init];
        _iconView.image = [UIImage imageNamed:@"me"];
        [_iconView sizeToFit];
    }
  
  _iconView.center = _point;

  //如果是在表格中出现多个圆角图标,需要异步重绘,性能会得到优化
  _iconView.layer.cornerRadius = _iconView.bounds.size.width * 0.5;
  _iconView.layer.masksToBounds = YES;
  [self addSubview:_iconView];
}

- (void)setOffsetY:(CGFloat)offsetY {
  _offsetY = offsetY;

  [self setNeedsDisplay];
}

@end
