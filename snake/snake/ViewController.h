//
//  ViewController.h
//  snake
//
//  Created by 耿华翼 on 16/11/14.
//  Copyright © 2016年 耿华翼. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SnakeView.h"
#import "AppDelegate.h"

@interface ViewController : UIViewController <snakedelegate>

@property (nonatomic) NSInteger try;

@end

