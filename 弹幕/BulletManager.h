//
//  BulletManager.h
//  弹幕
//
//  Created by 毛小锋 on 2017/6/9.
//  Copyright © 2017年 Zhe Jiang HongCheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BulletView;

@interface BulletManager : NSObject

@property (nonatomic,copy) void(^generateViewBlock)(BulletView *view);// 弹幕状态回调

// 弹幕开始执行
- (void)start;

// 弹幕停止执行
- (void)stop;

@end
