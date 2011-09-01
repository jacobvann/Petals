//
//  Dice.h
//  Petals
//
//  Created by Jacob Vann on 8/16/11.
//  Copyright 2011 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Dice : NSObject {
	int diceValue;
	UIImage *dicePicture;
	int lowValue;
	int highValue;
}

@property (nonatomic) int diceValue;
@property (nonatomic, retain) UIImage *dicePicture;
@property (nonatomic) int lowValue;
@property (nonatomic) int highValue;

- (void) rollDice;


@end
