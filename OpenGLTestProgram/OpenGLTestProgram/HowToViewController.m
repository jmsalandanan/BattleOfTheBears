//
//  HowToViewController.m
//  PrototypeApp
//
//  Created by Jose Mari Salandanan on 11/27/12.
//  Copyright (c) 2012 Jose Mari Salandanan. All rights reserved.
//

#import "HowToViewController.h"
#import "MainMenuViewController.h"

@interface HowToViewController ()

@end

@implementation HowToViewController

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

- (IBAction)backButtonPressed:(id)sender {
    MainMenuViewController *mainMenuViewController = [[MainMenuViewController alloc]init];
    mainMenuViewController.modalInPopover = UIModalTransitionStyleCrossDissolve;
    [self presentModalViewController:mainMenuViewController animated:YES];
}
@end
