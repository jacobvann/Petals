//
//  FlipsideViewController.h
//  Petals
//
//  Created by Jacob Vann on 8/16/11.
//  Copyright Apple 2011. All rights reserved.
//

@protocol FlipsideViewControllerDelegate;

@class PetalsAppDelegate;

@interface FlipsideViewController : UIViewController {
	id <FlipsideViewControllerDelegate> delegate;
    
    UILabel IBOutlet *numGuessesLabel;
    UILabel IBOutlet *numCorrectLabel;
    UILabel IBOutlet *percentCorrectLabel;
    
    PetalsAppDelegate *appDelegate;
    
    UIButton IBOutlet *clearButton;
}



@property (nonatomic, assign) id <FlipsideViewControllerDelegate> delegate;

- (IBAction)done;
- (void)updateLabels;
- (IBAction)pressClear:(id) sender;

@property (nonatomic, retain) UILabel *numGuessesLabel;
@property (nonatomic, retain) UILabel *numCorrectLabel;
@property (nonatomic, retain) UILabel *percentCorrectLabel;

@property (nonatomic, retain) UIButton *clearButton;

@end

@protocol FlipsideViewControllerDelegate
- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller;

@end

