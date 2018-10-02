//
//  addrankViewController.m
//  snake
//
//  Created by 耿华翼 on 11/23/16.
//  Copyright © 2016 耿华翼. All rights reserved.
//

#import "addrankViewController.h"
#import "ViewController.h"
#import "rankViewController.h"
#import "person.h"

@interface addrankViewController (){
    AppDelegate *addrankappdelegate;
}

@end

@implementation addrankViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    addrankappdelegate = [UIApplication sharedApplication].delegate;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)jumpBackToRank:(id)sender {
    rankViewController *VC = [self.storyboard instantiateViewControllerWithIdentifier:@"rank"];
    [self.navigationController pushViewController:VC animated:YES];
    
    if ([self.delegate respondsToSelector:@selector(addname:addModel:)]) {
        person *model = [[person alloc]init];
        model.name = self.palyerName.text;
        model.point = addrankappdelegate.finalpoint;
        [self.delegate addname:self addModel:model];
    }
    
}
- (IBAction)jumpToGame:(id)sender {
    //ViewController *VC = [self.storyboard instantiateViewControllerWithIdentifier:@"game"];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
