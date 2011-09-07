//
//  PetalsAppDelegate.h
//  Petals
//
//  Created by Jacob Vann on 8/16/11.
//  Copyright Apple 2011. All rights reserved.
//

@class MainViewController;

@interface PetalsAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
	NSMutableArray *DiceArray;                  // the array of dice objects
	int numDice;                                // the number of dice in our array
    int petalsValue;                            // the calculated "petals" value for the dice set
    MainViewController *mainViewController;     // a pointer to the mainViewController
    
    int totalGuesses;
    int totalCorrect;

}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) MainViewController *mainViewController;
@property (nonatomic, retain) NSMutableArray *DiceArray;
@property (nonatomic) int numDice;
@property (nonatomic) int petalsValue;

@property (nonatomic) int totalGuesses;
@property (nonatomic) int totalCorrect;

-(void) initDice;
-(void) rollTheDice;
-(void) updateDiceView;
-(BOOL) verifyAnswer:(int)theAnswer;
-(void) readStatsFromFile;
-(void) saveStatsToFile;

@end

