//
//  EndGameViewController.h
//  PrototypeApp
//
//  Created by Jose Mari Salandanan on 11/26/12.
//  Copyright (c) 2012 Jose Mari Salandanan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EndGameViewController : UIViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *playerScore;
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (assign) int temp;
@property (weak, nonatomic) IBOutlet UILabel *message;
- (IBAction)retryButtonPressed:(id)sender;
- (IBAction)mainMenuButtonPressed:(id)sender;

@end
