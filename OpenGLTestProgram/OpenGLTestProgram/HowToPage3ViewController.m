//
//  HowToPage3ViewController.m
//  AlienInvasion
//
//  Created by carmela.tortoza on 4/5/13.
//  Copyright (c) 2013 Jose Mari Salandanan. All rights reserved.
//

#import "HowToPage3ViewController.h"
#import "HowToPage2ViewController.h"
#import "MainMenuViewController.h"
#import "HowToPage4ViewController.h"


@interface HowToPage3ViewController ()

@end

@implementation HowToPage3ViewController

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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft);
}

- (IBAction)backButtonPressed:(id)sender {
    HowToPage2ViewController *mainMenuViewController = [[HowToPage2ViewController alloc]init];
    mainMenuViewController.modalInPopover = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:mainMenuViewController animated:YES completion:nil];
}

- (IBAction)homeButtonPressed:(id)sender {
    MainMenuViewController *mainMenuViewController = [[MainMenuViewController alloc]init];
    mainMenuViewController.modalInPopover = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:mainMenuViewController animated:YES completion:nil];
}

- (IBAction)forwardButtonPressed:(id)sender {
    HowToPage4ViewController *mainMenuViewController = [[HowToPage4ViewController alloc]init];
    mainMenuViewController.modalInPopover = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:mainMenuViewController animated:YES completion:nil];
}

@end
