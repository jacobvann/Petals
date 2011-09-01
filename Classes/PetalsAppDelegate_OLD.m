//
//  PetalsAppDelegate.m
//  Petals
//
//  Created by Jacob Vann on 8/16/11.
//  Copyright Apple 2011. All rights reserved.
//

#import "PetalsAppDelegate.h"
#import "MainViewController.h"
#import "Dice.h"
#import "Shake.h"

#include <stdlib.h>
#include <time.h>

@implementation PetalsAppDelegate


@synthesize window;
@synthesize mainViewController;
@synthesize DiceArray;
@synthesize numDice;


- (void)applicationDidFinishLaunching:(UIApplication *)application {
    
	time_t seconds;
	
    Shake *theShaker = [[Shake alloc] init];
    
	MainViewController *aController = [[MainViewController alloc] initWithNibName:@"MainView" bundle:nil];
	self.mainViewController = aController;
	[aController release];
	
	/* seed the random number generator */
	srand(time(&seconds));
	
    mainViewController.view.frame = [UIScreen mainScreen].applicationFrame;
	[window addSubview:[mainViewController view]];
    [window makeKeyAndVisible];
	
	
	self.numDice = 5;
	
	self.DiceArray = [[NSMutableArray alloc] initWithObjects:nil];
	
	[self initDice];
	[self rollTheDice];
	
	
	[self updateDiceView];
	

	
	
	/*
	Dice *tempDice1 = [[Dice alloc] init];

	NSLog(@"The dice values are:\n");
	for (int i = 0; i < self.numDice; i++) {
		tempDice1 = [self.DiceArray objectAtIndex:i] ;
		NSLog(@"%d ==> %d\n", i, tempDice1.diceValue);
	}
	 */
}



- (void)updateDiceView {
	
	MainViewController *viewController = self.mainViewController;
	
	Dice *tempDice = [DiceArray objectAtIndex:0];
	short diceVal = tempDice.diceValue;
	NSString *imgName = [NSString stringWithFormat:@"dice_%d.png", diceVal];
	viewController.diceView1.image = [UIImage imageNamed:imgName];
	
	tempDice = [DiceArray objectAtIndex:1];
	diceVal = tempDice.diceValue;
	imgName = [NSString stringWithFormat:@"dice_%d.png", diceVal];
	viewController.diceView2.image = [UIImage imageNamed:imgName];
	
	tempDice = [DiceArray objectAtIndex:2];
	diceVal = tempDice.diceValue;
	imgName = [NSString stringWithFormat:@"dice_%d.png", diceVal];
	viewController.diceView3.image = [UIImage imageNamed:imgName];
	
	tempDice = [DiceArray objectAtIndex:3];
	diceVal = tempDice.diceValue;
	imgName = [NSString stringWithFormat:@"dice_%d.png", diceVal];
	viewController.diceView4.image = [UIImage imageNamed:imgName];
	
	tempDice = [DiceArray objectAtIndex:4];
	diceVal = tempDice.diceValue;
	imgName = [NSString stringWithFormat:@"dice_%d.png", diceVal];
	viewController.diceView5.image = [UIImage imageNamed:imgName];
	
	[viewController release];
	
}





/* create an array of dice */
- (void) initDice {
	PetalsAppDelegate *delegate =
	(PetalsAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	NSMutableArray *myArray = delegate.DiceArray;
	
	for (int i = 0; i < numDice; i++) {
		Dice *tempDice = [[Dice alloc] init];
		[myArray addObject:tempDice];
	}
}

/* roll all dice in array */
- (void) rollTheDice {
	PetalsAppDelegate *delegate =
	(PetalsAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	NSMutableArray *array = delegate.DiceArray;
	
	NSLog(@"Rolling the %d dice\n", numDice);
	for (int i = 0; i < numDice; i++) {
		NSLog(@"Rolling...\n");
		Dice *tempDice = [array objectAtIndex:i];
		NSLog(@"Before roll with %d result %d\n", tempDice.diceValue, tempDice.highValue);
		[tempDice rollDice];
		NSLog(@"Rolled with %d result %d\n", tempDice.diceValue, tempDice.highValue);
	}
}

- (void)dealloc {
    [mainViewController release];
	[DiceArray release];
    [window release];
	

	
    [super dealloc];
}


@end
