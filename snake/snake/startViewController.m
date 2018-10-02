//
//  startViewController.m
//  snake
//
//  Created by 耿华翼 on 11/22/16.
//  Copyright © 2016 耿华翼. All rights reserved.
//

#import "startViewController.h"
#import "ViewController.h"
#import "rankViewController.h"
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>

@interface startViewController (){
    AppDelegate *startDelegate;
    SystemSoundID gamesound;
    NSTimer *music;
}

@end

@implementation startViewController

AVAudioPlayer *audioPlayer;


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];
    startDelegate = [UIApplication sharedApplication].delegate;
    startDelegate.level = 0.35;
    NSURL *gameUrl = [[NSBundle mainBundle] URLForResource:@"5164" withExtension:@"wav"];
    // set up volume
    audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:gameUrl error:nil];
    audioPlayer.numberOfLoops = -1;
    audioPlayer.volume = 0.5f;
    [audioPlayer play];
    
    

//    AudioServicesCreateSystemSoundID((__bridge CFURLRef)gameUrl, &gamesound);
//    AudioServicesPlaySystemSound(gamesound);
//    music = [NSTimer scheduledTimerWithTimeInterval:26.5 target:self selector:@selector(playmusic) userInfo:nil repeats:YES];

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

- (IBAction)jumpToGame:(id)sender {
    SystemSoundID sound;
    NSURL  *soundUrl = [[NSBundle mainBundle] URLForResource:@"btm" withExtension:@"mp3"];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)soundUrl, &sound);
    AudioServicesPlaySystemSound(sound);
    
    ViewController *viewc = [self.storyboard instantiateViewControllerWithIdentifier:@"game"];
    [self.navigationController pushViewController:viewc animated:YES];
}

- (IBAction)setLevel:(id)sender {
    switch ([sender selectedSegmentIndex]) {
        case 0:
            startDelegate.level = 0.35;
            break;
        case 1:
            startDelegate.level = 0.23;
            break;
        case 2:
            startDelegate.level = 0.1;
            break;
        default:
            break;
    }
}

- (void) playmusic{
    AudioServicesPlaySystemSound(gamesound);
}

- (IBAction)jumpToRank:(id)sender {
    SystemSoundID sound;
    NSURL  *soundUrl = [[NSBundle mainBundle] URLForResource:@"btm" withExtension:@"mp3"];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)soundUrl, &sound);
    AudioServicesPlaySystemSound(sound);
    
    rankViewController * rankVC = [self.storyboard instantiateViewControllerWithIdentifier:@"rank"];
    [self.navigationController pushViewController:rankVC animated:YES];
}

- (IBAction)jumpToInfinite:(id)sender {
    SystemSoundID sound;
    NSURL  *soundUrl = [[NSBundle mainBundle] URLForResource:@"btm" withExtension:@"mp3"];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)soundUrl, &sound);
    AudioServicesPlaySystemSound(sound);
    
    startDelegate.inifinte = YES;
    ViewController *viewc = [self.storyboard instantiateViewControllerWithIdentifier:@"game"];
    [self.navigationController pushViewController:viewc animated:YES];
    
}


@end
