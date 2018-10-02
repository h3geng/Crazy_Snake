//
//  rankViewController.h
//  snake
//
//  Created by 耿华翼 on 11/23/16.
//  Copyright © 2016 耿华翼. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface rankViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
- (IBAction)jumpBackToRoot:(id)sender;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end
