//
//  AppDelegate.h
//  snake
//
//  Created by 耿华翼 on 16/11/14.
//  Copyright © 2016年 耿华翼. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, assign) NSInteger finalpoint;
@property (nonatomic) bool fail;
@property (nonatomic, assign) CGFloat level;
@property (nonatomic, assign) NSString *playerName;
@property (nonatomic) bool inifinte;
@property (nonatomic) bool back;

@end

