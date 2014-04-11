//
//  CardGameViewController.m
//  Matchisimo
//
//  Created by Matias Casanova on 10/04/14.
//  Copyright (c) 2014 Matias Casanova. All rights reserved.
//

#import "CardGameViewController.h"
#import "Deck.h"
#import "PlayingCardDeck.h"

@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipCount;
@property (nonatomic) Deck *deck;
@end

@implementation CardGameViewController

- (Deck *)deck{
    if (!_deck) _deck=[self createDeck];
    return _deck;
}

- (Deck *)createDeck{
    return [PlayingCardDeck new];
}

- (void) setFlipCount:(int)flipCount{
    _flipCount=flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
    NSLog(@"fliCount = %d", self.flipCount);
}

- (IBAction)touchCard:(UIButton *)sender
{
    if ([sender.currentTitle length]) {
        [sender setBackgroundImage:[UIImage imageNamed:@"cardback"]
                          forState:UIControlStateNormal];
        [sender setTitle:@"" forState:UIControlStateNormal];
        self.flipCount++;
    }else{
        Card *card = [self.deck drawRandomCard];
        if(card){
            [sender setBackgroundImage:[UIImage imageNamed:@"card"]
                              forState:UIControlStateNormal];
            [sender setTitle:[card contents]forState:UIControlStateNormal];
            self.flipCount++;
        }
    }
}


@end
