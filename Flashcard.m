//
//  Flashcard.m
//  Lab4
//
//  Created by Lauren Champeau on 3/7/17.
//  Copyright © 2017 Lauren Champeau. All rights reserved.
//

#import "Flashcard.h"

@implementation Flashcard

// Implement initialization functions
- (instancetype) initWithQuestion: (NSString *) question
                           answer: (NSString *) ans{
    
    self = [super init];
    if (self){
        _question = question;
        _answer = ans;
    }
    
    return self;
}

- (instancetype) initWithQuestion: (NSString *) question
                           answer: (NSString *) ans
                       isFavorite: (BOOL) isFav{
    
    self = [super init];
    if (self){
        _question = question;
        _answer = ans;
        _isFavorite = isFav;
    }
    return self;
}

// Method to convert dictionary to flashcard
-(instancetype) initFromDictionary:(NSDictionary *)flashcardDict{
    self = [super init];
    if (self){
        _question = [flashcardDict valueForKey:kQuestion];
        _answer = [flashcardDict valueForKey:kAnswer];
    }
    return self;
}

// Method to convert flashcard to dictionary
- (NSDictionary *) convertFlashcardToDictionary:(Flashcard *) flashcardVar{
    NSArray *objectsArray = [[NSArray alloc] initWithObjects:flashcardVar.question, flashcardVar.answer, nil];
    NSArray *keysArray = [[NSArray alloc] initWithObjects:kQuestion, kAnswer, nil];
    NSDictionary *flashcardAsDictionary = [NSDictionary dictionaryWithObjects:objectsArray forKeys:keysArray];
    return flashcardAsDictionary;
}

@end
