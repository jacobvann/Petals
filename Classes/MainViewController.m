//
//  MainViewController.m
//  Petals
//
//  Created by Jacob Vann on 8/16/11.
//  Copyright Apple 2011. All rights reserved.
//

#import "MainViewController.h"
#import "MainView.h"

#import "Dice.h"
#import "PetalsAppDelegate.h"

#include <stdlib.h>
#include <time.h>

@implementation MainViewController

@synthesize diceView1;
@synthesize diceView2;
@synthesize diceView3;
@synthesize diceView4;
@synthesize diceView5;

@synthesize answerField;
@synthesize goButton;

@synthesize diceRotationHigh;
@synthesize diceRotationLow;
@synthesize diceXOffsetHigh;
@synthesize diceXOffsetLow;
@synthesize diceYOffsetHigh;
@synthesize diceYOffsetLow;

@synthesize diceSoundID;




#pragma mark Methods

- (BOOL)canBecomeFirstResponder {
    // we must be first responder in order to "see" the shake gesture
    return YES;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    // we must be first responder in order to "see" the shake gesture
    [self becomeFirstResponder];
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}



 // Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
 - (void)viewDidLoad {
     //[super viewDidLoad];
     
     // set some ranges for the dice animation
     diceRotationHigh = 10;
     diceRotationLow = 20;
     diceXOffsetLow = -1000;
     diceXOffsetHigh = 1000;
     diceYOffsetLow = -1000;
     diceYOffsetHigh = 1000;
     
     // create the sound id for the dice sound
     NSString *path = [[NSBundle mainBundle] pathForResource:@"dice" ofType:@"wav"];
     AudioServicesCreateSystemSoundID((CFURLRef)[NSURL fileURLWithPath:path], &diceSoundID);
     
     answerField.delegate = self;
     
 }




/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */


- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller {
	[self dismissModalViewControllerAnimated:YES];
}



- (IBAction)showInfo {    
	FlipsideViewController *controller = [[FlipsideViewController alloc] initWithNibName:@"FlipsideView" bundle:nil];
	controller.delegate = self;
	
	controller.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
	[self presentModalViewController:controller animated:YES];
	
	[controller release];
}



/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[diceView1 release];
	[diceView2 release];
	[diceView3 release];
	[diceView4 release];
    [diceView5 release];
	
    [answerField release];
    [goButton release];
    
    [super dealloc];
}

#pragma mark UIView callbacks

// this is a callback for the shake gesture
- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    if ( event.subtype == UIEventSubtypeMotionShake ) {
        NSLog(@"Shakey shakey!\n");
        [self shakeDice];
        
    }
    
}

// This method is called when the user hits "OK" on the answer dialog window
// we want to reshake the dice and then make the view take first reponder again
// (so that the shake action is captured)
- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger) buttonIndex {
    [self shakeDice];
    [self becomeFirstResponder];
}

// when the user is done with the text field
// we relenquish control back to the main view
-(IBAction) textFieldDoneEditing:(id)sender {
    [sender resignFirstResponder];
    [self becomeFirstResponder];
}

// if the user taps on the background when the keyboard
// is active, we want to relenquish control back to the main
// view
-(IBAction) backgroundTap:(id)sender {
    [answerField resignFirstResponder];
    [self becomeFirstResponder];
}



- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    	    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    	    return (newLength > 3) ? NO : YES;
}
 


#pragma mark Instance Methods

// this method "shakes" the dice by 
// 1. calling the rollTheDice method on the app delegate
// 2. calling updateDiceView to update the images
// 3. playing the dice sound
// 4. animating the dice
- (void) shakeDice {
    // Do something
    PetalsAppDelegate *delegate =
    (PetalsAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    [delegate rollTheDice];
    [delegate updateDiceView];
    
    // animate the dice
    [self playDiceSound];
    [self animateDice];
}



// this method plays a sound for when the dice are shaken
// called by shakeDice
-(void) playDiceSound {
    AudioServicesPlaySystemSound(diceSoundID);
}

// this method "animates" the dice by rotating and shifting
// them slightly.  Called by shakeDice.
- (IBAction)animateDice {
    [UIView animateWithDuration:0.2
                     animations:^{
                         // rotations
                         diceView1.transform = CGAffineTransformMakeRotation(rand() % ((diceRotationHigh - diceRotationLow) + diceRotationLow) / 50.0);
                         diceView2.transform = CGAffineTransformMakeRotation(rand() % ((diceRotationHigh - diceRotationLow) + diceRotationLow) / 50.0);
                         diceView3.transform = CGAffineTransformMakeRotation(rand() % ((diceRotationHigh - diceRotationLow) + diceRotationLow) / 50.0);
                         diceView4.transform = CGAffineTransformMakeRotation(rand() % ((diceRotationHigh - diceRotationLow) + diceRotationLow) / 50.0);
                         diceView5.transform = CGAffineTransformMakeRotation(rand() % ((diceRotationHigh - diceRotationLow) + diceRotationLow) / 50.0);
                         // Positions
                         diceView1.transform = CGAffineTransformMakeTranslation((rand() % (diceXOffsetHigh - diceXOffsetLow) + diceXOffsetLow) / 100.0,
                                                                                (rand() % (diceYOffsetHigh - diceYOffsetLow) + diceYOffsetLow) / 100.0);
                         diceView2.transform = CGAffineTransformMakeTranslation((rand() % (diceXOffsetHigh - diceXOffsetLow) + diceXOffsetLow) / 100.0,
                                                                                (rand() % (diceYOffsetHigh - diceYOffsetLow) + diceYOffsetLow) / 100.0);
                         diceView3.transform = CGAffineTransformMakeTranslation((rand() % (diceXOffsetHigh - diceXOffsetLow) + diceXOffsetLow) / 100.0,
                                                                                (rand() % (diceYOffsetHigh - diceYOffsetLow) + diceYOffsetLow) / 100.0);
                         diceView4.transform = CGAffineTransformMakeTranslation((rand() % (diceXOffsetHigh - diceXOffsetLow) + diceXOffsetLow) / 100.0,
                                                                                (rand() % (diceYOffsetHigh - diceYOffsetLow) + diceYOffsetLow) / 100.0);
                         diceView5.transform = CGAffineTransformMakeTranslation((rand() % (diceXOffsetHigh - diceXOffsetLow) + diceXOffsetLow) / 100.0,
                                                                                (rand() % (diceYOffsetHigh - diceYOffsetLow) + diceYOffsetLow) / 100.0);
                     }];
}

// this method is called when the user submits an answer
// it compares their answer with the correct answer, and
// prepares an alert box to display the result.
-(IBAction) pressGo:(id) sender {
    int theAnswer = [answerField.text intValue];
    NSLog(@"Pressed go with answer of %d\n", theAnswer);
    // resign the keyboard's first responder status
    [answerField resignFirstResponder];
    
    PetalsAppDelegate *delegate =
    (PetalsAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    NSMutableString *theMessage = [[NSMutableString alloc] init];
    NSMutableString *theTitle = [[NSMutableString alloc] init];
    
    if ([answerField.text length] == 0) {
        [theTitle setString:@"Invalid Answer!"];
        [theMessage setString:@"Please enter a number."];
    } else if ([delegate verifyAnswer:(int)theAnswer]) {
        [theTitle setString:@"CORRECT!"];
        [theMessage setString:[NSString stringWithFormat:@"Yes, %d is the answer.", theAnswer]];
        
        // another guess and another win
        if (delegate.totalGuesses < 9999) {
            delegate.totalGuesses++;
        }
        if (delegate.totalCorrect < 9999) {
            delegate.totalCorrect++;
        }
    } else {
        [theTitle setString:@"Incorrect."];
        [theMessage setString:[NSString stringWithFormat:@"Sorry, %d is not the answer.", theAnswer]];
        
        // chalk up another guess
        if (delegate.totalGuesses < 9999) {
            delegate.totalGuesses++;
        }
    }
    
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:theTitle 
                          message:theMessage 
                          delegate:self
                          cancelButtonTitle:nil
                          otherButtonTitles:@"OK", nil
                          ];
    [alert show];
    [alert autorelease]; 
    
    [theMessage autorelease];
    [theTitle autorelease];
    
    if (delegate.totalGuesses > 0) {
        NSLog(@"Total Guesses: %d  Total Correct: %d   %%Correct: %0.0lf\n", delegate.totalGuesses, delegate.totalCorrect, ((float) delegate.totalCorrect / (float) delegate.totalGuesses) * 100.0);
    }    

    [delegate saveStatsToFile];
}



@end
