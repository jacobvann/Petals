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

#include <stdlib.h>
#include <time.h>

@implementation PetalsAppDelegate


@synthesize window;
@synthesize mainViewController;
@synthesize DiceArray;
@synthesize numDice;
@synthesize petalsValue;

@synthesize totalGuesses;
@synthesize totalCorrect;


- (void)applicationDidFinishLaunching:(UIApplication *)application {
    
	time_t seconds;
	
    MainViewController *aController = [[MainViewController alloc] initWithNibName:@"MainView" bundle:nil];
	self.mainViewController = aController;
	[aController release];
    
    
	/* seed the random number generator */
	srand(time(&seconds));
	
    mainViewController.view.frame = [UIScreen mainScreen].applicationFrame;
	[window addSubview:[mainViewController view]];
    [window makeKeyAndVisible];
	
    totalGuesses = 0;
    totalCorrect = 0;
    
	// we will have 5 dice in our array
	self.numDice = 5;
	
	self.DiceArray = [[NSMutableArray alloc] initWithObjects:nil];
	
    // this inits the DiceArray with dice objects
	[self initDice];
    
    // select random values for each die in the array
	[self rollTheDice];
    
    // update the dice pictures in the MainView
	[self updateDiceView];
    
    [self readStatsFromFile];
	
}

- (void)saveStatsToFile {
    
    // get a handle for the File for storing player stats
    NSArray *arrayPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *docFilePath = [[arrayPaths objectAtIndex:0] stringByAppendingString:@"/stats.txt"];
    
    NSLog(@"%@\n", docFilePath);
    NSLog(@"%d:%d\n", totalCorrect, totalGuesses); 
    [[NSString stringWithFormat:@"%d:%d\n", totalCorrect, totalGuesses] writeToFile:docFilePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
}


- (void)readStatsFromFile {
    // get a handle for the File for storing player stats
    NSArray *arrayPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *docFilePath = [[arrayPaths objectAtIndex:0] stringByAppendingString:@"/stats.txt"];
    
    NSString *fileContents = [NSString stringWithContentsOfFile:docFilePath encoding:NSUTF8StringEncoding error:nil];
    
    NSLog(@"Read from file: %@\n", fileContents);
    
    if (fileContents != NULL) {
        NSArray *lineElements = [fileContents componentsSeparatedByString:@":"];
    
        if ([lineElements count] == 2) {
            totalCorrect = [[lineElements objectAtIndex:0] intValue];
            totalGuesses = [[lineElements objectAtIndex:1] intValue];
        } else {
            NSLog(@"Invalid data in file\n");
        }
    } else {
        NSLog(@"File not found\n");
    }
}


- (void)updateDiceView {

	NSLog(@"UpdateDiceView\n");
    
    // we need a pointer to the mainView controller to get at the
    // dice images
	MainViewController *viewController = self.mainViewController;
	
    // yes, this should be in a for loop, but 
    // I don't know how to make an array of UIImages (yet)
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

	
}

// does the passed answer match the real petals value?
- (BOOL) verifyAnswer:(int)theAnswer {
    return (theAnswer == petalsValue);
}


// create an array of dice
- (void) initDice {
	PetalsAppDelegate *delegate =
	(PetalsAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	NSMutableArray *myArray = delegate.DiceArray;
	
	for (int i = 0; i < numDice; i++) {
		Dice *tempDice = [[Dice alloc] init];
		[myArray addObject:tempDice];
	}

}

// "roll" each dice in the array
- (void) rollTheDice {
	PetalsAppDelegate *delegate =
	(PetalsAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	NSMutableArray *array = delegate.DiceArray;
	
    // initialize "petals" value
    petalsValue = 0;
    
    // roll the dice in the array
	NSLog(@"Rolling the %d dice\n", numDice);
	for (int i = 0; i < numDice; i++) {
		NSLog(@"Rolling...\n");
        
        // grab a temporary dice object pointer
		Dice *tempDice = [array objectAtIndex:i];
		[tempDice rollDice];
		NSLog(@"Rolled with %d result %d\n", tempDice.diceValue, tempDice.highValue);
	
        // calculate petals value for dice and add it to total
        // if you don't know how the petals value is calculated,
        // I'm not telling you ... ;)
        if (tempDice.diceValue == 3) {
            petalsValue += 2;
        } else if (tempDice.diceValue == 5) {
            petalsValue += 4;
        }
    }
    
    NSLog(@"petalsValue is %d\n", petalsValue);

}

- (void)dealloc {
    [mainViewController release];
	[DiceArray release];
    [window release];	
    [super dealloc];
}


@end
