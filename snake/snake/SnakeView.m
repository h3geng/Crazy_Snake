//
//  SnakeView.m
//  snake
//
//  Created by 耿华翼 on 16/11/14.
//  Copyright © 2016年 耿华翼. All rights reserved.
//

#import "SnakeView.h"
#import "FKPoint.h"
#import <AudioToolbox/AudioToolbox.h>
#import "ViewController.h"

@implementation SnakeView{
    //纪录蛇的点，最后一个点代表蛇头
    NSMutableArray *snakeData;
    
    //定义食物所在地
    FKPoint *foodPos;
    FKPoint *foodPos1;
    FKPoint *foodPos2;
    FKPoint *wall;
    NSTimer *timer;
    NSTimer *fooddis;
    UIColor *bgColor;
    UIImage *cherryImage;
    UIImage *rockImage;
    SystemSoundID gu;
    SystemSoundID crash;
    SystemSoundID bad;
    NSInteger getpoint;
    NSInteger badpoint;
    AppDelegate *snakeappdelegate;
    UILabel *countpoint;
    UILabel *posion;
    NSTimer *music;
    int stop;
    UIAlertController *overAlert;
    AppDelegate *appdele;
    AppDelegate *backsnakeappdelegate;
}

@synthesize orient;


- (void)createControlButtons{
    stop = 1;
    snakeappdelegate.back = NO;
    UIButton *stopBtn = [[UIButton alloc]initWithFrame:CGRectMake(300, 50, 50, 50)];
    [stopBtn setTitle:@"Pause" forState:UIControlStateNormal];
    stopBtn.titleLabel.font = [UIFont fontWithName:@"Pause" size:30];
    [stopBtn addTarget:self action:@selector(stop) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:stopBtn];
    
    UIButton *restartBtn = [[UIButton alloc]initWithFrame:CGRectMake(300, 10, 50, 50)];
    [restartBtn setTitle:@"Exit" forState:UIControlStateNormal];
    restartBtn.titleLabel.font = [UIFont fontWithName:@"Exit" size:30];
    [restartBtn addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:restartBtn];
    
}


-(void)stop{
    if (stop == 1){
        [timer invalidate];
        stop = 0;
    }
    else{
        timer = [NSTimer scheduledTimerWithTimeInterval:snakeappdelegate.level target:self selector:@selector(move) userInfo:nil repeats:YES];
        stop = 1;
    }
}

-(void)close{
    [timer invalidate];
    snakeappdelegate.back = YES;
}


                                                                               

- (id) initWithFrame:(CGRect)frame{
    snakeappdelegate = [UIApplication sharedApplication].delegate;
    self = [super initWithFrame:frame];
    if(self){
        if (snakeappdelegate.inifinte == YES) {
            [self createControlButtons];
            snakeappdelegate.back = NO;
            //设置分数板
            getpoint = 0;
            countpoint = [[UILabel alloc] init];
            countpoint.frame = CGRectMake(10, 30, 200, 100);
            countpoint.text = [NSString stringWithFormat:@"SCORE：%lu",getpoint];
            countpoint.textColor = [UIColor whiteColor];
            countpoint.font = [UIFont systemFontOfSize:24];
            [self addSubview:countpoint];
            cherryImage = [UIImage imageNamed:@"cherry.png"];
            //加载游戏背景图片，并将背景图片转换为平铺形式的颜色
            bgColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"grass.jpg"]];
            //获取两个音效文件
            NSURL *guUrl = [[NSBundle mainBundle] URLForResource:@"9" withExtension:@"wav"];
            NSURL *crashUrl = [[NSBundle mainBundle] URLForResource:@"die" withExtension:@"wav"];
            //加载两个音效
            AudioServicesCreateSystemSoundID((__bridge CFURLRef)guUrl, &gu);
            AudioServicesCreateSystemSoundID((__bridge CFURLRef)crashUrl, &crash);
            [self startGame];
        }
        else{
            [self createControlButtons];
            snakeappdelegate.back = NO;
            //设置分数板
            getpoint = 0;
            countpoint = [[UILabel alloc] init];
            countpoint.frame = CGRectMake(10, 30, 200, 100);
            countpoint.text = [NSString stringWithFormat:@"Score：%lu",getpoint];
            countpoint.textColor = [UIColor whiteColor];
            countpoint.font = [UIFont systemFontOfSize:24];
            
            //毒食物
            badpoint = 0;
            posion = [[UILabel alloc] init];
            posion.frame = CGRectMake(10, 50, 300, 150);
            posion.text = [NSString stringWithFormat:@"Poisonous foods：%lu",badpoint];
            posion.textColor = [UIColor redColor];
            posion.font = [UIFont systemFontOfSize:24];
            
            [self addSubview:countpoint];
            [self addSubview:posion];
            cherryImage = [UIImage imageNamed:@"cherry.png"];
            //加载游戏背景图片，并将背景图片转换为平铺形式的颜色
            bgColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"grass.jpg"]];
            //获取两个音效文件
            NSURL *guUrl = [[NSBundle mainBundle] URLForResource:@"9" withExtension:@"wav"];
            NSURL *crashUrl = [[NSBundle mainBundle] URLForResource:@"die" withExtension:@"wav"];
            NSURL *badUrl = [[NSBundle mainBundle] URLForResource:@"damn" withExtension:@"mp3"];
            //加载两个音效
            AudioServicesCreateSystemSoundID((__bridge CFURLRef)guUrl, &gu);
            AudioServicesCreateSystemSoundID((__bridge CFURLRef)crashUrl, &crash);
            AudioServicesCreateSystemSoundID((__bridge CFURLRef)badUrl, &bad);
            //AudioServicesPlaySystemSound(bad);
            [self startGame];
        }
    }
    return self;
}

- (void) startGame{
    // NSLog(@"startGame");
    //fkpoint的第一个参数控制位于水平第几格，第2个参数控制位于垂直第几格
    snakeData = [NSMutableArray arrayWithObjects:
                 [[FKPoint alloc] initWithX:1 indexY:10],
                 [[FKPoint alloc] initWithX:2 indexY:10],
                 [[FKPoint alloc] initWithX:3 indexY:10],
                 [[FKPoint alloc] initWithX:4 indexY:10],
                 [[FKPoint alloc] initWithX:5 indexY:10], nil];
    //定义蛇的初始移动方向
    orient = kRight;
    NSLog(@"startGame1");
    timer = [NSTimer scheduledTimerWithTimeInterval:snakeappdelegate.level target:self selector:@selector(move) userInfo:nil repeats:YES];
    
    //食物消失 重新显示
    fooddis = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(disapper) userInfo:nil repeats:YES];
    NSLog(@"startGame2");
    
    //AudioServicesPlaySystemSound(gamesound);
    
    //music = [NSTimer scheduledTimerWithTimeInterval:26 target:self selector:@selector(playmusic) userInfo:nil repeats:YES];
}



- (void) move{
   // NSLog(@"move");
    //除了蛇头受方向控制之外，其他点都是占他的前一个点
    //获取最后一个点，作为蛇头
    FKPoint *first = [snakeData objectAtIndex: snakeData.count - 1];
    FKPoint *head = [[FKPoint alloc] initWithX:first.x indexY:first.y];
    switch (orient) {
        case kDown:
            head.y = head.y + 1;
            break;
            
        case Kleft:
            head.x  = head.x - 1;
            break;
            
        case kRight:
            head.x = head.x + 1;
            break;
            
        case kUp:
            head.y = head.y - 1;
            break;
        default:
            break;
    }
    
    
    //蛇头超出界面或者与蛇身相碰
    if (head.x < 0 || head.x > WiDTH - 1 || head.y < 0 || head.y > HEIGHT - 1 || [snakeData containsObject:head] || badpoint == 3) {
        snakeappdelegate.fail = YES;
        //播放碰撞音效
        //NSLog(@"haha");
        AudioServicesPlayAlertSound(crash);
        //[overAlert showViewController:overAlert sender:nil];
        [timer invalidate];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, (self.frame.size.height - 40) / 2, self.frame.size.width, 45)];
        label.layer.cornerRadius = 5;
        label.layer.borderColor = [[UIColor blackColor] CGColor];
        label.layer.borderWidth = 5;
        label.font = [UIFont systemFontOfSize:38];
        [self addSubview:label];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = @"GAME OVER";
    }
    
    //蛇头于食物点重合
    if ([head isEqual:foodPos] || [head isEqual:foodPos1] || [head isEqual:foodPos2] || [head isEqual:wall]) {
        //NSLog(@"%@", sna)
        if ([head isEqual:wall] && snakeappdelegate.inifinte == NO) {
            badpoint++;
            snakeappdelegate.finalpoint = getpoint;
            posion.text = [NSString stringWithFormat:@"POISONOUS FOODS：%lu",badpoint];
            posion.textColor = [UIColor redColor];
            wall = nil;
            AudioServicesPlaySystemSound(bad);
            [self disapper];
            
        }else{
            getpoint++;
            snakeappdelegate.finalpoint = getpoint;
            
            countpoint.text = [NSString stringWithFormat:@"SCORE：%lu",getpoint];
            countpoint.textColor = [UIColor whiteColor];
            
            //播放吃食物音效
            AudioServicesPlaySystemSound(gu);
            //将食物添加成新的蛇头
            if ([head isEqual:foodPos]) {
                [snakeData addObject:foodPos];
                //食物清空
                foodPos = nil;
            }else if ([head isEqual:foodPos1]){
                [snakeData addObject:foodPos1];
                foodPos1 = nil;
            }else if ([head isEqual:wall]){
                [snakeData addObject:wall];
                foodPos1 = nil;
            }
            else{
                [snakeData addObject:foodPos2];
                foodPos2 = nil;
            }
        }
    }else{
        //从第一个点开始，控制蛇身向前
        for (int i = 0; i < snakeData.count - 1; i++) {
            //将i个点的坐标设置为第i+1个点的坐标
            FKPoint *curpoint = [snakeData objectAtIndex:i];
            FKPoint *nexpoint = [snakeData objectAtIndex:i+1];
            curpoint.x = nexpoint.x;
            curpoint.y = nexpoint.y;
        }
        //重新设置蛇头坐标 如果每次不更新蛇头怎么知道当前的蛇头在哪里
        [snakeData setObject:head atIndexedSubscript:(snakeData.count - 1)];
    }
    if (snakeappdelegate.inifinte == NO && wall == nil) {
        NSLog(@"haha");
        while (true) {
            FKPoint *newall = [[FKPoint alloc] initWithX:arc4random() % WiDTH indexY:arc4random() % HEIGHT];
            if (![snakeData containsObject:newall] && newall != foodPos && newall != foodPos1 && newall != foodPos2) {
                wall = newall;
                break;
            }
        }
    }
    //看有没有食物在界面上
    if (foodPos == nil || foodPos1 == nil || foodPos2 == nil || (snakeappdelegate.inifinte == NO && wall == nil)) {
        if (foodPos == nil) {
            while (true) {
                FKPoint *newFoodPos = [[FKPoint alloc]initWithX:arc4random() % WiDTH indexY:arc4random() % HEIGHT];
                //如果新产生的食物点没有位于蛇身上
                if (![snakeData containsObject:newFoodPos] && newFoodPos != foodPos1 && newFoodPos != foodPos2) {
                    foodPos = newFoodPos;
                    break; //成功生成了不在蛇身上的食物和不在其他食物的点上
                }
            }
        }
        else if (foodPos1 == nil) {
            while (true) {
                FKPoint *newFoodPos = [[FKPoint alloc]initWithX:arc4random() % WiDTH indexY:arc4random() % HEIGHT];
                //如果新产生的食物点没有位于蛇身上
                if (![snakeData containsObject:newFoodPos] && newFoodPos != foodPos && newFoodPos != foodPos2) {
                    foodPos1 = newFoodPos;
                    break; //成功生成了不在蛇身上的食物和不在其他食物的点上
                }
            }
        }else if (snakeappdelegate.inifinte == NO && wall == nil){
            while (true) {
                FKPoint *newFoodPos = [[FKPoint alloc]initWithX:arc4random() % WiDTH indexY:arc4random() % HEIGHT];
                //如果新产生的食物点没有位于蛇身上
                if (![snakeData containsObject:newFoodPos] && newFoodPos != foodPos && newFoodPos != foodPos2) {
                    wall= newFoodPos;
                    break; //成功生成了不在蛇身上的食物和不在其他食物的点上
                }
            }
        }
        else{
            while (true) {
                FKPoint *newFoodPos = [[FKPoint alloc]initWithX:arc4random() % WiDTH indexY:arc4random() % HEIGHT];
                //如果新产生的食物点没有位于蛇身上
                if (![snakeData containsObject:newFoodPos] && newFoodPos != foodPos && newFoodPos != foodPos1) {
                    foodPos2 = newFoodPos;
                    break; //成功生成了不在蛇身上的食物和不在其他食物的点上
                }
            }
        }
    }
    [self setNeedsDisplay];      ///////////////////??????
}


-(void) disapper{
    foodPos = nil;
    foodPos1 = nil;
    foodPos2 = nil;
    if(snakeappdelegate.inifinte == NO){
        wall = nil;
    }
    while (true) {
        //创建3个新点
        FKPoint *newFoodPos = [[FKPoint alloc]initWithX:arc4random() % WiDTH indexY:arc4random() % HEIGHT];
        FKPoint *newFoodPos1 = [[FKPoint alloc]initWithX:arc4random() % WiDTH indexY:arc4random() % HEIGHT];
        FKPoint *newFoodPos2 = [[FKPoint alloc]initWithX:arc4random() % WiDTH indexY:arc4random() % HEIGHT];
        FKPoint *newwall;
        if(snakeappdelegate.inifinte == NO){
            newwall = [[FKPoint alloc]initWithX:arc4random() % WiDTH indexY:arc4random() % HEIGHT];
        }
        //保证各点不重合
        if (![snakeData containsObject:newFoodPos] && ![snakeData containsObject:newFoodPos1] && ![snakeData containsObject:newFoodPos2] && ![snakeData containsObject:newwall] && newFoodPos != newFoodPos1 && newFoodPos != newFoodPos2 && newFoodPos != newwall && newFoodPos1 != newwall && newFoodPos2 != newwall && newFoodPos1 != newFoodPos2) {
            foodPos = newFoodPos;
            foodPos1 = newFoodPos1;
            foodPos2 = newFoodPos2;
            if (snakeappdelegate.inifinte == NO){
                wall = newwall;
            }
            break;
        }
    }
}

//定义绘制蛇头的方法
- (void) drawHeadInRect:(CGRect)rect context:(CGContextRef)ctx{
    //NSLog(@"drawHeadInRect");
    CGContextBeginPath(ctx);
    CGFloat startAngle;
    switch (orient) {
        case kUp:
            startAngle = M_PI * 7 / 4;
            break;
            
        case kDown:
            startAngle = M_PI * 3 / 4;
            break;
        
        case Kleft:
            startAngle = M_PI * 5 / 4;
            break;
            
        case kRight:
            startAngle = M_PI * 1 / 4;
            break;
            
        default:
            break;
    }
    //添加一段弧作为路径
    CGContextAddArc(ctx, CGRectGetMidX(rect), CGRectGetMidY(rect), CELL_SIZE / 2, startAngle, M_PI * 1.5 + startAngle,  0);
    
    //将绘制点移动到中心
    CGContextAddLineToPoint(ctx, CGRectGetMidX(rect), CGRectGetMidY(rect));
    
    //关闭路径
    CGContextClosePath(ctx);
    CGContextFillPath(ctx);
}

- (void) drawRect:(CGRect)rect{
    //NSLog(@"drawRect");

    //获取绘图API
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(ctx, [bgColor CGColor]);
    
    //绘制背景
    CGContextFillRect(ctx, CGRectMake(0, 0, WiDTH * CELL_SIZE, HEIGHT * CELL_SIZE));
    
    //绘制文字
//    [@"Crazy Snake" drawAtPoint:CGPointMake(50, 20) withAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"Heiti SC" size:40],NSFontAttributeName,[UIColor colorWithRed:1 green:0 blue:1 alpha:.4],NSForegroundColorAttributeName,nil]];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 10,self.frame.size.width, 45)];
    label.layer.cornerRadius = 5;
    label.textColor = [UIColor colorWithRed:1 green:0 blue:1 alpha:.4];
    //label.layer.borderColor = [[UIColor blueColor] CGColor];
    //label.layer.borderWidth = 5;
    label.font = [UIFont systemFontOfSize:38];
    [self addSubview:label];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"Crazy Snake";

    
    //绘制蛇的填充颜色
    CGContextSetRGBFillColor(ctx, 1, 0.5, 0, 1);
    
    //遍历蛇的数据，绘制蛇的数据
    for (int i = 0; i < snakeData.count; i++) {
        //为每个蛇的点（纪录的是在数组中的位置），在屏幕上绘制一个圆点
        FKPoint *cp = [snakeData objectAtIndex:i];
        
        //定义将要绘制蛇身点的矩形
        CGRect rect = CGRectMake(cp.x * CELL_SIZE, cp.y * CELL_SIZE, CELL_SIZE, CELL_SIZE);
        
        //绘制蛇尾 让蛇的尾巴小点
        if (i < 4) {
            CGFloat inset = (4 - i);
            CGContextFillEllipseInRect(ctx, CGRectInset(rect, inset, inset));
        }
        
        //如果是最后一个元素,代表蛇头 绘制蛇头
        else if (i == snakeData.count - 1){
            [self drawHeadInRect:rect context:ctx];
        }else{
            CGContextFillEllipseInRect(ctx, rect);
        }
    }
    
    //绘制食物图片
    //UIImage cherry = [UIImage imageNamed:@"cherry.png"];
    //CGRect cherryrect = CGRectMake(foodPos.x, foodPos.y, CELL_SIZE, CELL_SIZE);
    //CGContextFillEllipseInRect(ctx, cherryrect);
    
    [cherryImage drawAtPoint:CGPointMake(foodPos.x * CELL_SIZE, foodPos.y * CELL_SIZE)];
    [cherryImage drawAtPoint:CGPointMake(foodPos1.x * CELL_SIZE, foodPos1.y * CELL_SIZE)];
    [cherryImage drawAtPoint:CGPointMake(foodPos2.x * CELL_SIZE, foodPos2.y * CELL_SIZE)];
    if (snakeappdelegate.inifinte == NO) {
        [cherryImage drawAtPoint:CGPointMake(wall.x * CELL_SIZE, wall.y * CELL_SIZE)];
    }
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
