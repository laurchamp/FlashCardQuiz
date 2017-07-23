//
//  ViewController.m
//  Lab4
//
//  Created by Lauren Champeau on 3/6/17.
//  Copyright © 2017 Lauren Champeau. All rights reserved.
//

#import "ViewController.h"
#import "FlashcardsModel.h"
#import "Flashcard.h"

@interface ViewController ()

// Private properties
@property FlashcardsModel *flashcardModel;
@property (weak, nonatomic) IBOutlet UILabel *cardLabel;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.flashcardModel = [FlashcardsModel sharedModel];
    
    if (self.flashcardModel.numberOfFlashcards == 0){
        self.cardLabel.text = @"There are no more flashcards";
    }
    else{
        Flashcard *randomCard = [self.flashcardModel randomFlashcard];
        
        self.cardLabel.text = randomCard.question;
        
        // Gestures
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapRecognized:)];
        [self.view addGestureRecognizer:singleTap];
        
        UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTapRecognized:)];
        doubleTap.numberOfTapsRequired = 2;
        [self.view addGestureRecognizer:doubleTap];
        
        [singleTap requireGestureRecognizerToFail:doubleTap];
        
        UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeLeftGestureRecognized:)];
        swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
        [self.view addGestureRecognizer:swipeLeft];
        
        UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeRightGestureRecognized:)];
        swipeLeft.direction = UISwipeGestureRecognizerDirectionRight;
        [self.view addGestureRecognizer:swipeRight];
        }
}

// Gesture selector implementations
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Animations
- (void) fadeInNewCard : (NSString *) question {
    self.cardLabel.textColor = UIColor.blackColor;
    self.cardLabel.text = question;
    [UIView animateWithDuration:1.0
                     animations:^{
                         self.cardLabel.alpha = 1;
                     }];
}

- (void) displayNewCard : (NSString *) question {
    self.cardLabel.textColor = UIColor.blackColor;
    [UIView animateWithDuration:1.0
                     animations:^{
                         self.cardLabel.alpha = 0;
                     }
                     completion:^(BOOL finished){
                         [self fadeInNewCard:question];
                     }];
}

- (void) dispAnswerHelper : (NSString *) answer{
    [UIView animateWithDuration:1.0
                     animations:^{
                         self.cardLabel.alpha = 0;
                     }
                     completion:^(BOOL finished){
                         [self displayAnswer:answer];
                     }];
}

- (void) displayAnswer : (NSString *) answer {
    self.cardLabel.text = answer;
    if (self.cardLabel.textColor == UIColor.blackColor){
        self.cardLabel.textColor = [UIColor colorWithRed:(153.0f/255.0f) green:0.0 blue:0.0 alpha:1.0];
    }
    else{
        self.cardLabel.textColor = UIColor.blackColor;
    }
    [UIView animateWithDuration:1.0
                     animations:^{
                         self.cardLabel.alpha = 1;
                     }];
}

// Gestures
- (void)singleTapRecognized: (UITapGestureRecognizer *) recognizer{
    if (self.flashcardModel.numberOfFlashcards == 0){
        self.cardLabel.text = @"There are no more flashcards";
    }
    else{
        Flashcard *randomCard = [self.flashcardModel randomFlashcard];
        [self displayNewCard:randomCard.question];
    }
}

- (void)doubleTapRecognized: (UITapGestureRecognizer *) recognizer{
    if (self.flashcardModel.numberOfFlashcards == 0){
        self.cardLabel.text = @"Please add some more flashcards.";
    }
    else{
        Flashcard *currentCard = [self.flashcardModel flashcardAtIndex:self.flashcardModel.currentIndex];
        [self dispAnswerHelper:currentCard.answer];
    }
}

- (void)swipeLeftGestureRecognized: (UISwipeGestureRecognizer *) recognizer{
    Flashcard *prevCard = [self.flashcardModel prevFlashcard];
    
    [self displayNewCard:prevCard.question];
}

- (void)swipeRightGestureRecognized: (UISwipeGestureRecognizer *) recognizer{
    Flashcard *nextCard = [self.flashcardModel nextFlashcard];
    
    [self displayNewCard:nextCard.question];
}
@end
