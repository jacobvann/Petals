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

@implementation MainViewController

@synthesize diceView1;
@synthesize diceView2;
@synthesize diceView3;
@synthesize diceView4;
@synthesize diceView5;

@synthesize answerField;
@synthesize goButton;


- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
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
     
 }


- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    if ( event.subtype == UIEventSubtypeMotionShake ) {
        NSLog(@"Shakey shakey!\n");
        // Do something
        PetalsAppDelegate *delegate =
        (PetalsAppDelegate *)[[UIApplication sharedApplication] delegate];
        
        [delegate rollTheDice];
        [delegate updateDiceView];

    }
    
//    if ([super respondsToSelector:@selector(motionEnded:withEvent:)]) {
//        [super motionEnded:motion withEvent:event];
//    }

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


-(IBAction) textFieldDoneEditing:(id)sender {
    [sender resignFirstResponder];
    [self becomeFirstResponder];
}

-(IBAction) backgroundTap:(id)sender {
    [answerField resignFirstResponder];
    [self becomeFirstResponder];
}

-(IBAction) pressGo:(id) sender {
    int theAnswer = [answerField.text intValue];
    NSLog(@"Pressed go with answer of %d\n", theAnswer);
    // resign the keyboard's first responder status
    [answerField resignFirstResponder];
    
    PetalsAppDelegate *delegate =
    (PetalsAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    
    if ([answerField.text length] == 0) {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"Invalid Answer!" 
                              message:[NSString stringWithFormat:@"Please enter a number."] 
                              delegate:self
                              cancelButtonTitle:nil
                              otherButtonTitles:@"OK", nil
                              ];
        [alert show];
        [alert autorelease]; 
    } else if ([delegate verifyAnswer:(int)theAnswer]) {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"CORRECT!" 
                              message:[NSString stringWithFormat:@"%d is the correct answer.", theAnswer] 
                              delegate:self
                              cancelButtonTitle:nil
                              otherButtonTitles:@"OK", nil
                              ];
        [alert show];
        [alert autorelease];
    } else {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"Incorrect" 
                              message:[NSString stringWithFormat:@"Sorry, %d is incorrect.", theAnswer] 
                              delegate:self
                              cancelButtonTitle:nil
                              otherButtonTitles:@"OK", nil
                              ];
        [alert show];
        [alert autorelease];
    }

    [self becomeFirstResponder];
    
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



@end
