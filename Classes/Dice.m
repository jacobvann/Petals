//
//  Dice.m
//  Petals
//
//
//  Created by Jacob Vann on 8/16/11.
//  Copyright 2011 Apple. All rights reserved.
//
// implements a simple 6-sided die object

#import "Dice.h"
#include <stdlib.h>
#include <time.h>

@implementation Dice

@synthesize diceValue;
@synthesize dicePicture;
@synthesize lowValue;
@synthesize highValue;

// select a random "side" of the die
-(void) rollDice {
	//diceValue = 5;
	diceValue = rand() % (self.highValue - self.lowValue + 1) + self.lowValue;
	NSLog(@"*********** setting dice value to %d\n", diceValue);
}

-(void) dealloc {
	[dicePicture release];
	[super dealloc];
}

-(id) init {
	lowValue = 1;
	highValue = 6;
	diceValue = 99;
	
	return self;
}

@end
