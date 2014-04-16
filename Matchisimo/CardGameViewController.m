//
//  CardGameViewController.m
//  Matchisimo
//
//  Created by Matias Casanova on 10/04/14.
//  Copyright (c) 2014 Matias Casanova. All rights reserved.
//

#import "CardGameViewController.h"
#import "Deck.h"
#import "CardMatchingGame.h"

@interface CardGameViewController ()
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (nonatomic,strong) CardMatchingGame *game;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UISwitch *modeSwitch;
@end

@implementation CardGameViewController

- (CardMatchingGame *) game{
    if (!_game) _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                          usingDeck:[self createDeck]];
    return _game;
}


- (Deck *)createDeck{ //abstract
    return nil;
}


- (IBAction)touchCard:(UIButton *)sender{
    int chosenButtonIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:chosenButtonIndex];
    [self updateUI];
}
- (IBAction)touchReDealButton:(UIButton *)sender {
    _game = nil;
    [self updateUI];
}
- (IBAction)changeModeSwitch:(UISwitch *)sender {
    self.game.perfectMatchMode = sender.isOn;
}

- (void)updateUI{
    for (UIButton *cardButton in  self.cardButtons) {
        int cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        [cardButton setTitle:[self titleForCard:card]
                    forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card]
                              forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    [self.modeSwitch setOn: self.game.isPerfectMatchMode];
    self.modeSwitch.enabled = !self.game.hasStarted;
}

- (NSString *) titleForCard:(Card *) card{
    return card.isChosen ? card.contents : @"";
}

- (UIImage * )backgroundImageForCard:(Card *)card{
    return [UIImage imageNamed:card.isChosen ? @"card" : @"cardback"];
}

@end
