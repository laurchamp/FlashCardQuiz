//
//  Flashcard.h
//  Lab4
//
//  Created by Lauren Champeau on 3/7/17.
//  Copyright © 2017 Lauren Champeau. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString *const kQuestion = @"question";
static NSString *const kAnswer = @"answer";

@interface Flashcard : NSObject

//Public, read-only properties for question and answer
@property (strong, nonatomic, readonly) NSString *question;
@property (strong, nonatomic, readonly) NSString *answer;

//Public property for isFavorite
@property BOOL isFavorite;

//Public methods
// Initializing the flashcard
- (instancetype) initWithQuestion: (NSString *) question
                           answer: (NSString *) ans;
- (instancetype) initWithQuestion: (NSString *) question
                           answer: (NSString *) ans
                       isFavorite: (BOOL) isFav;

// Method to convert to flashcard from dictionary (for saving to plist)
- (instancetype) initFromDictionary: (NSDictionary*) flashcardDict;

// Method to convert to dictionary from flashcard (for saving to plist)
- (NSDictionary *) convertFlashcardToDictionary:(Flashcard *) flashcardVar;

@end
