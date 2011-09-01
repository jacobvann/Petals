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
	NSMutableArray *DiceArray;
	int numDice;
    int petalsValue;
    MainViewController *mainViewController;

}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) MainViewController *mainViewController;
@property (nonatomic, retain) NSMutableArray *DiceArray;
@property (nonatomic) int numDice;
@property (nonatomic) int petalsValue;


-(void) initDice;
-(void) rollTheDice;
-(void) updateDiceView;
-(BOOL) verifyAnswer:(int)theAnswer;

@end

