//
//  HighScoreViewController.h
//  PrototypeApp
//
//  Created by Jose Mari Salandanan on 11/27/12.
//  Copyright (c) 2012 Jose Mari Salandanan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HighScoreViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *highName;
@property (weak, nonatomic) IBOutlet UILabel *highScore;
- (IBAction)backButtonPressed:(id)sender;

@end
