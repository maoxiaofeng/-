//
//  BulletView.m
//  弹幕
//
//  Created by 毛小锋 on 2017/6/9.
//  Copyright © 2017年 Zhe Jiang HongCheng. All rights reserved.
//

#import "BulletView.h"

#define Padding 10

@interface BulletView ()

@property (nonatomic,strong) UILabel *commentLabel;// 弹幕Label

@end

@implementation BulletView

// 初始化弹幕
- (instancetype)initWithComment:(NSString *)comment {
    if (self = [super init]) {
        self.backgroundColor = [UIColor redColor];
        
        // 计算弹幕的实际宽度
        NSDictionary *attr = @{NSFontAttributeName:[UIFont systemFontOfSize:14]};
        CGFloat width = [comment sizeWithAttributes:attr].width;
        
        self.bounds = CGRectMake(0, 0, width + 2 * Padding, 30);
        self.commentLabel.text = comment;
        self.commentLabel.frame = CGRectMake(Padding, 0, width, 30);
    }
    return self;
}

// 开始动画
- (void)startAnimation {
    
    // 根据弹幕长度执行动画效果
    // 根据v = s/t,时间相同情况下，距离越长，速度就越快
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat duration = 4.0f;
    CGFloat wholeWidth = screenWidth + CGRectGetWidth(self.bounds);
    
    // 弹幕开始
    if (self.moveStatusBlock) {
        self.moveStatusBlock(Start);
    }
    
    // t = s/v
    CGFloat speed = wholeWidth/duration;
    CGFloat enterDuration = CGRectGetWidth(self.bounds)/speed;
    
    [self performSelector:@selector(enterScreen) withObject:nil afterDelay:enterDuration];
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    
    __block CGRect frame = self.frame;
    [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveLinear  animations:^{
        frame.origin.x -= wholeWidth;
        self.frame = frame;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        
        if (self.moveStatusBlock) {
            self.moveStatusBlock(End);
        }
    }];
    
}

- (void)enterScreen {
    if (self.moveStatusBlock) {
        self.moveStatusBlock(Enter);
    }
}

// 结束动画
- (void)stopAnimation {
    [self.layer removeAllAnimations];
    [self removeFromSuperview];
}

- (UILabel *)commentLabel {
    if (!_commentLabel) {
        _commentLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _commentLabel.font = [UIFont systemFontOfSize:14];
        _commentLabel.textColor = [UIColor whiteColor];
        _commentLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_commentLabel];
    }
    return _commentLabel;
}

@end
