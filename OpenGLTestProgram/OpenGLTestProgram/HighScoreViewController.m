//
//  HighScoreViewController.m
//  PrototypeApp
//
//  Created by Jose Mari Salandanan on 11/27/12.
//  Copyright (c) 2012 Jose Mari Salandanan. All rights reserved.
//

#import "HighScoreViewController.h"
#import "MainMenuViewController.h"

@interface HighScoreViewController ()

@end

@implementation HighScoreViewController
@synthesize highName;
@synthesize highScore;

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
    // Get the stored data before the view loads
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *name = [defaults objectForKey:@"name"];
    int score = [defaults integerForKey:@"score"];
    // Update the UI elements with the saved data
    [highName setText:name];
    [highScore setText:[NSString stringWithFormat:@"%d",score]];
}

- (void)viewDidUnload
{
    [self setHighName:nil];
    [self setHighScore:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft);
}

- (IBAction)backButtonPressed:(id)sender {
    MainMenuViewController *mainMenuViewController = [[MainMenuViewController alloc]init];
    mainMenuViewController.modalInPopover = UIModalTransitionStyleCrossDissolve;
    [self presentModalViewController:mainMenuViewController animated:YES];
}


@end
