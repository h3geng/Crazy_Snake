//
//  rankViewController.m
//  snake
//
//  Created by 耿华翼 on 11/23/16.
//  Copyright © 2016 耿华翼. All rights reserved.
//

#import "rankViewController.h"
#import "addrankViewController.h"
#import "person.h"
#import <AudioToolbox/AudioToolbox.h>

@interface rankViewController () <addRankDelegate>

@property (nonatomic,strong) NSMutableArray *peopleArr;

@end

@implementation rankViewController

-(NSMutableArray *)peopleArr{
    if (!_peopleArr) {
        //peopleArr = [NSKeyedUnarchiver unarchiveObjectWithFile:ContactFilePath];
        if (_peopleArr == nil){
            _peopleArr = [NSMutableArray array];
        }
    }
    return _peopleArr;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.peopleArr.count;
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellid = @"mycell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellid];
    }
    person *people = self.peopleArr[indexPath.row];
    cell.textLabel.text = people.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%lu", people.point];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) addname:(addrankViewController *)addVc addModel:(person *)people{
    [self.peopleArr addObject:people];
    [self.tableView reloadData];
    
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    id vc = segue.destinationViewController;
    if ([vc isKindOfClass:[addrankViewController class]]) {
        addrankViewController * addVc = vc;
        addVc.delegate = self;
    }
}


- (IBAction)jumpBackToRoot:(id)sender {
    SystemSoundID sound;
    NSURL  *soundUrl = [[NSBundle mainBundle] URLForResource:@"btm" withExtension:@"mp3"];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)soundUrl, &sound);
    AudioServicesPlaySystemSound(sound);
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}
@end
