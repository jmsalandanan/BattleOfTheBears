//
//  EndGameViewController.m
//  PrototypeApp
//
//  Created by Jose Mari Salandanan on 11/26/12.
//  Copyright (c) 2012 Jose Mari Salandanan. All rights reserved.
//

#import "EndGameViewController.h"
#import "SGGViewController.h"
#import "MainMenuViewController.h"
@interface EndGameViewController ()

@end

@implementation EndGameViewController
@synthesize playerScore;
@synthesize nameField;
@synthesize temp;
//@synthesize message;
UITextField *message;
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
//    [nameField setDelegate:self];
    [playerScore setText:[NSString stringWithFormat:@"Score: %d",temp]];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    int score = [defaults integerForKey:@"score"];
    if(score>temp)
    {
//        [message setText:@"Game Over!"];
        [nameField setAlpha:0];
//        [message setAlpha:0];
    }
    else
    {
//        [message setText:@"New High Score!!"];
        UIAlertView *highScore = [[UIAlertView alloc] initWithTitle:@"New High Score!" message:@"\n\n\n" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];

        message = [[UITextField alloc] initWithFrame:CGRectMake(12, 60, 260, 25)];
        [message becomeFirstResponder];
        [message setBackgroundColor:[UIColor whiteColor]];
//        highScore.transform = CGAffineTransformMakeTranslation(120.0f, 0.0f);

        highScore.alertViewStyle = UIAlertViewStylePlainTextInput;
        UITextField *message = [highScore textFieldAtIndex:0];
        [highScore textFieldAtIndex:0].delegate = self;

        [highScore addSubview:message];
        [message becomeFirstResponder];
        message.keyboardType = UIKeyboardTypeAlphabet;
        message.keyboardAppearance = UIKeyboardAppearanceAlert;
        message.autocorrectionType = UITextAutocorrectionTypeNo;
        [highScore performSelector:@selector(show) withObject:nil afterDelay:0];
        NSLog(@"%@",message.text);
        [nameField setAlpha:1];
    }

}

- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    UITextField *message = [actionSheet textFieldAtIndex:0];
    nameField.text = message.text;
}

#pragma mark - UIAlertViewDelegate Methods

- (void)didPresentAlertView:(UIAlertView *)alertView {
    [[alertView textFieldAtIndex:0] becomeFirstResponder];
}

- (void)viewDidUnload
{
    [self setPlayerScore:nil];
//    [self setNameField:nil];
    message=NULL;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft);
}

- (IBAction)retryButtonPressed:(id)sender {
    [self check];
    SGGViewController *gameViewController = [[SGGViewController alloc]init];
    gameViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentModalViewController:gameViewController animated:YES];

}

- (IBAction)mainMenuButtonPressed:(id)sender {
    [self check];
    MainMenuViewController *mainMenuViewController = [[MainMenuViewController alloc]init];
    mainMenuViewController.modalInPopover = UIModalTransitionStyleCrossDissolve;
    [self presentModalViewController:mainMenuViewController animated:YES];
    
}

-(void)check
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    int score = [defaults integerForKey:@"score"];
    if(score>temp)
    {

        return;
    }
    else
    {

        [self save];
    }

}
-(void)save
{
    [nameField resignFirstResponder];
    // Create strings and integer to store the text info
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *name = [nameField text];
    int score = temp;
    [defaults setObject:name forKey:@"name"];
    [defaults setInteger:score forKey:@"score"];
    [defaults synchronize];
    NSLog(@"Data saved");
}
-(BOOL)textFieldShouldReturn:(UITextField *)textFields
{
    [textFields resignFirstResponder];
    return YES;
}

@end
