//
//  HowToPage1ViewController.m
//  AlienInvasion
//
//  Created by carmela.tortoza on 4/4/13.
//  Copyright (c) 2013 Jose Mari Salandanan. All rights reserved.
//

#import "HowToPage1ViewController.h"
#import "MainMenuViewController.h"
#import "HowToViewController.h"
#import "HowToPage2ViewController.h"


@interface HowToPage1ViewController ()

@end

@implementation HowToPage1ViewController

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
    // Do any additional setup after loading the view from its nib.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)backButtonPressed:(id)sender {
    HowToViewController *mainMenuViewController = [[HowToViewController alloc]init];
    mainMenuViewController.modalInPopover = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:mainMenuViewController animated:YES completion:nil];
}

- (IBAction)homeButtonPressed:(id)sender {
    MainMenuViewController *mainMenuViewController = [[MainMenuViewController alloc]init];
    mainMenuViewController.modalInPopover = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:mainMenuViewController animated:YES completion:nil];
}

- (IBAction)forwardButtonPressed:(id)sender {
    HowToPage2ViewController *mainMenuViewController = [[HowToPage2ViewController alloc]init];
    mainMenuViewController.modalInPopover = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:mainMenuViewController animated:YES completion:nil];
}
@end
