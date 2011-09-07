//
//  MainViewController.h
//  Petals
//
//  Created by Jacob Vann on 8/16/11.
//  Copyright Apple 2011. All rights reserved.
//

#import "FlipsideViewController.h"
#import <CoreMotion/CoreMotion.h>
#import <AudioToolbox/AudioToolbox.h>


@interface MainViewController : UIViewController <FlipsideViewControllerDelegate, UITextFieldDelegate>  {
	
	IBOutlet UIImageView *diceView1;
	IBOutlet UIImageView *diceView2;
	IBOutlet UIImageView *diceView3;
	IBOutlet UIImageView *diceView4;
	IBOutlet UIImageView *diceView5;
    
    UIButton *goButton;
    
    UITextField *answerField; 
    
    int diceRotationHigh;
    int diceRotationLow;
    int diceXOffsetHigh;
    int diceXOffsetLow;
    int diceYOffsetHigh;
    int diceYOffsetLow;
    
    SystemSoundID diceSoundID;

    
}

@property (nonatomic, retain) UIImageView *diceView1;
@property (nonatomic, retain) UIImageView *diceView2;
@property (nonatomic, retain) UIImageView *diceView3;
@property (nonatomic, retain) UIImageView *diceView4;
@property (nonatomic, retain) UIImageView *diceView5;


@property (nonatomic) int diceRotationHigh;
@property (nonatomic) int diceRotationLow;
@property (nonatomic) int diceXOffsetHigh;
@property (nonatomic) int diceXOffsetLow;
@property (nonatomic) int diceYOffsetHigh;
@property (nonatomic) int diceYOffsetLow;

@property (nonatomic) SystemSoundID diceSoundID;

@property (nonatomic, retain) IBOutlet UITextField *answerField;

@property (nonatomic, retain) IBOutlet UIButton *goButton;

 

- (IBAction)showInfo;
- (IBAction)textFieldDoneEditing:(id)sender;
- (IBAction)backgroundTap:(id)sender;
- (IBAction)pressGo:(id) sender;

- (void)shakeDice;
- (void)animateDice;

- (void)playDiceSound;

@end
