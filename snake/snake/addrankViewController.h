//
//  addrankViewController.h
//  snake
//
//  Created by 耿华翼 on 11/23/16.
//  Copyright © 2016 耿华翼. All rights reserved.
//

#import <UIKit/UIKit.h>
@class person, addrankViewController;

@protocol addRankDelegate <NSObject>

@optional

- (void) addname: (addrankViewController *) addVc addModel:(person *) people;

@end

@interface addrankViewController : UIViewController
- (IBAction)jumpBackToRank:(id)sender;

@property (strong, nonatomic) IBOutlet UITextField *palyerName;

- (IBAction)jumpToGame:(id)sender;

@property (nonatomic,assign) id<addRankDelegate>  delegate;

@end
