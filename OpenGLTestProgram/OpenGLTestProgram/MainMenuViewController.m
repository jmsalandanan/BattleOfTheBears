//
//  MainMenuViewController.m
//  PrototypeApp
//
//  Created by Jose Mari Salandanan on 11/26/12.
//  Copyright (c) 2012 Jose Mari Salandanan. All rights reserved.
//

#import "MainMenuViewController.h"
#import "HighScoreViewController.h"
#import "SGGViewController.h"
#import "HowToViewController.h"
#import "SimpleAudioEngine.h"

@interface MainMenuViewController ()

@end

@implementation MainMenuViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //[[SimpleAudioEngine sharedEngine]playBackgroundMusic:@"menu.mp3"];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{

    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft);
}

- (IBAction)startGameButtonPressed:(id)sender {

        SGGViewController *gameViewController = [[SGGViewController alloc]init];
        gameViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self presentModalViewController:gameViewController animated:YES];    
}

- (IBAction)howToButtonPressed:(id)sender {
    HowToViewController *howToViewController = [[HowToViewController alloc]init];
    howToViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentModalViewController:howToViewController animated:YES];
}

- (IBAction)highScoreButtonPressed:(id)sender {
    HighScoreViewController *highScoreViewController = [[HighScoreViewController alloc]init];
    highScoreViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentModalViewController:highScoreViewController animated:YES];
}
@end
