//
//  SnakeView.h
//  snake
//
//  Created by 耿华翼 on 16/11/14.
//  Copyright © 2016年 耿华翼. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"


@interface UIViewController()

@property(strong,nonatomic) UIButton *button;

@end

//地图上的格子
#define WiDTH 20
#define HEIGHT 35

//定义每个格子的大小
#define CELL_SIZE 19.049

typedef enum{
    kDown = 0,
    Kleft,
    kRight,
    kUp,
} Orient;

@protocol snakedelegate <NSObject>

@end


@interface SnakeView : UIView <UIAlertViewDelegate>


@property (nonatomic,assign) NSInteger passpoint;

//定义蛇的移动方向
@property (nonatomic, assign) Orient orient;


- (void) drawHeadInRect:(CGRect)rect context:(CGContextRef) ctx;


@end
