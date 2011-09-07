//
//  FlipsideViewController.m
//  Petals
//
//  Created by Jacob Vann on 8/16/11.
//  Copyright Apple 2011. All rights reserved.
//

#import "FlipsideViewController.h"
#import "PetalsAppDelegate.h"


@implementation FlipsideViewController

@synthesize delegate;

@synthesize numGuessesLabel;
@synthesize numCorrectLabel;
@synthesize percentCorrectLabel;

@synthesize clearButton;


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor viewFlipsideBackgroundColor];
    [self updateLabels];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

}

-(IBAction) pressClear:(id) sender {
    NSLog(@"User pressed clear button\n");
    // display confirmation box
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"Are you sure?" 
                          message:@"Are you sure you want to clear the statistics?"
                          delegate:self
                          cancelButtonTitle:@"Cancel"
                          otherButtonTitles:@"Clear", nil
                          ];
    [alert show];
    [alert autorelease]; 
}

// This method is called when the user hits "OK" on the answer dialog window
// we want to reshake the dice and then make the view take first reponder again
// (so that the shake action is captured)
- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger) buttonIndex {
    
    if (buttonIndex == 0) {
         // cancel
    } else if (buttonIndex == 1) {
         // ok
    
        appDelegate = (PetalsAppDelegate *) [[UIApplication sharedApplication] delegate];
        appDelegate.totalCorrect = 0;
        appDelegate.totalGuesses = 0;
        [appDelegate saveStatsToFile];
        
        
        
        [self updateLabels];
    }
    
}

- (void)updateLabels {
    appDelegate = (PetalsAppDelegate *) [[UIApplication sharedApplication] delegate];
    
    float percentCorrect = 0.0;
    int numCorrect = appDelegate.totalCorrect;
    int numGuesses = appDelegate.totalGuesses;
    if (numGuesses > 0) {
        percentCorrect = (float) ((float) numCorrect / (float) numGuesses) * 100.0;
    }
    
    numGuessesLabel.text = [NSString stringWithFormat:@"%d", numGuesses];
    numCorrectLabel.text = [NSString stringWithFormat:@"%d", numCorrect];
    percentCorrectLabel.text = [NSString stringWithFormat:@"%0.0f", percentCorrect];
    
    NSLog(@"Updating labels: %@ %@ %@\n", numGuessesLabel.text, numCorrectLabel.text, percentCorrectLabel.text);
}


- (IBAction)done {
	[self.delegate flipsideViewControllerDidFinish:self];	
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
    [super dealloc];
}


@end
