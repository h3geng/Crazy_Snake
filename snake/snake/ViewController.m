//
//  ViewController.m
//  snake
//
//  Created by 耿华翼 on 16/11/14.
//  Copyright © 2016年 耿华翼. All rights reserved.
//

#import "ViewController.h"
#import "SnakeView.h"
#import "rankViewController.h"
#import "addrankViewController.h"

@interface ViewController (){
    SnakeView *snakeView;
    AppDelegate *appdele;
    UIAlertController *overAlert;
    NSTimer *check;
    AppDelegate *backappdele;
}

@end

@implementation ViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];
     NSLog(@"viewDidLoad");
    self.try = 10;
    appdele = [UIApplication sharedApplication].delegate;
    appdele.fail = NO;
    check = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(failornot) userInfo:nil repeats:YES];
    
    
    //self.point.text = [NSString stringWithFormat:@"%lu", appdele.finalpoint];
    
    // Do any additional setup after loading the view, typically from a nib.
    
    //创建snakeview控件
    snakeView = [[SnakeView alloc]initWithFrame:CGRectMake(0, 0, WiDTH * CELL_SIZE, HEIGHT * CELL_SIZE)];
    
    //为snakeview控件设置边框和圆角
//    snakeView.layer.borderWidth = 3;
//    snakeView.layer.borderColor = [[UIColor redColor]CGColor];
//    snakeView.layer.cornerRadius = 6;
//    snakeView.layer.masksToBounds = YES;
    
    //设置self.view控件支持交互
    self.view.userInteractionEnabled = YES;
    
    //设置self.view控件支持多点触碰
    self.view.multipleTouchEnabled = YES;
    
    for (int i = 0; i < 4; i++) {
        //创建手势处理器，制定使用该控制器的handleSwipe：方法处理清扫手势
        UISwipeGestureRecognizer *gesture = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwip:)];
        
        //设置该手势处理器只处理i个手指的清扫手势
        gesture.numberOfTouchesRequired = 1;
        
        //设置该手势处理器只处理1<< i方向的清扫手势
        gesture.direction = 1 << i;
        
        //为self。view控件添加手势处理器
        [self.view addGestureRecognizer:gesture];
    }
    [self.view addSubview:snakeView];
}

//实现手势处理的方法，该方法应该声明一个形参
//当该方法被激发时 手势处理器会作为参数传给该方法的参数


-(void) handleSwip:(UISwipeGestureRecognizer *) gesture{
    //获取清扫手势的方向
    NSUInteger dir = gesture.direction;
    switch (dir) {
        case UISwipeGestureRecognizerDirectionLeft:
            if (snakeView.orient != kRight) {   //只要不是向右，就可改变方向
                snakeView.orient = Kleft;
            }
            break;
            
        case UISwipeGestureRecognizerDirectionUp:
            if (snakeView.orient != kDown) {   //只要不是向下，就可改变方向
                snakeView.orient = kUp;
            }
            break;
            
        case UISwipeGestureRecognizerDirectionDown:
            if (snakeView.orient != kUp) {   //只要不是向上，就可改变方向
                snakeView.orient = kDown;
            }
            break;
            
        case UISwipeGestureRecognizerDirectionRight:
            if (snakeView.orient != Kleft) {   //只要不是向左，就可改变方向
                snakeView.orient = kRight;
            }
            break;
            
        default:
            break;
    }
}

- (void) failornot{
    if (appdele.fail == YES) {
        overAlert = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"GAME OVER, SCORE：%lu", appdele.finalpoint] message:@"Try again?" preferredStyle:UIAlertControllerStyleAlert];
        sleep(1);
        [overAlert addAction:[UIAlertAction actionWithTitle:@"Back to main menu！" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action){
            appdele.inifinte = NO;
            [self.navigationController popToRootViewControllerAnimated:YES];
        }]];
        [overAlert addAction:[UIAlertAction actionWithTitle:@"Again！" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action){
            [self viewDidLoad];
        }]];
//        [overAlert addAction:[UIAlertAction actionWithTitle:@"载入史册！" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action){
//            addrankViewController *rankVC = [self.storyboard instantiateViewControllerWithIdentifier:@"addrank"];
//            [self.navigationController pushViewController:rankVC animated:YES];
//        }]];
        [self presentViewController:overAlert animated:YES completion:nil];
        [check invalidate];
    }
    if (appdele.back == YES){
        appdele.inifinte = NO;
        [self.navigationController popToRootViewControllerAnimated:YES];
        //appdele.back = NO;
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
