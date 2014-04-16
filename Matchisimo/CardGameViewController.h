//
//  CardGameViewController.h
//  Matchisimo
//
//  Created by Matias Casanova on 10/04/14.
//  Copyright (c) 2014 Matias Casanova. All rights reserved.
//

//abstract

#import <UIKit/UIKit.h>
#import "Deck.h"

@interface CardGameViewController : UIViewController

- (Deck *) createDeck; //abstract

@end
