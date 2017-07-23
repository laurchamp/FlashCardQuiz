//
//  FlashcardsModel.h
//  Lab4
//
//  Created by Lauren Champeau on 3/7/17.
//  Copyright © 2017 Lauren Champeau. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Flashcard.h"



@interface FlashcardsModel : NSObject

// Public properties
@property (nonatomic, readonly) NSUInteger currentIndex;

// Public methods
+ (instancetype) sharedModel;

- (NSUInteger) numberOfFlashcards;

- (Flashcard *) randomFlashcard;

- (Flashcard *) flashcardAtIndex: (NSUInteger)index;

- (Flashcard *) nextFlashcard;

- (Flashcard *) prevFlashcard;

- (void) insertWithQuestion: (NSString *) question
                     answer: (NSString *) ans
                   favorite: (BOOL)fav;

- (void) insertWithQuestion: (NSString *) question
                     answer: (NSString *) ans
                   favorite: (BOOL) fav
                    atIndex: (NSUInteger) index;

- (void) removeFlashcard;

- (void) removeFlashcardAtIndex: (NSUInteger) index;

- (void) toggleFavorite;

- (NSArray *) favoriteFlashcards;
@end
