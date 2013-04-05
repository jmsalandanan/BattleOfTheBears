//
//  HowToPage4ViewController.m
//  AlienInvasion
//
//  Created by carmela.tortoza on 4/5/13.
//  Copyright (c) 2013 Jose Mari Salandanan. All rights reserved.
//

#import "HowToPage4ViewController.h"
#import "HowToPage3ViewController.h"
#import "MainMenuViewController.h"

@interface HowToPage4ViewController ()

@end

@implementation HowToPage4ViewController

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
    HowToPage3ViewController *mainMenuViewController = [[HowToPage3ViewController alloc]init];
    mainMenuViewController.modalInPopover = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:mainMenuViewController animated:YES completion:nil];
}

- (IBAction)homeButtonPressed:(id)sender {
    MainMenuViewController *mainMenuViewController = [[MainMenuViewController alloc]init];
    mainMenuViewController.modalInPopover = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:mainMenuViewController animated:YES completion:nil];
}

@end
