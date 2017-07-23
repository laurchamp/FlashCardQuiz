//
//  FlashcardsModel.m
//  Lab4
//
//  Created by Lauren Champeau on 3/7/17.
//  Copyright © 2017 Lauren Champeau. All rights reserved.
//

#import "FlashcardsModel.h"
#import "Flashcard.h"

static NSString *const kFlashcardsPList = @"Flashcards.plist";

@interface FlashcardsModel()

// Private properties
@property (nonatomic, strong) NSMutableArray *flashcards;
@property (nonatomic, strong) NSString *filepath;
@end


@implementation FlashcardsModel

+ (instancetype) sharedModel{
    static FlashcardsModel *flashcardModel = nil;
    
    // GCD - Grand Central Dispatch
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        flashcardModel = [[FlashcardsModel alloc] init];
    });
    
    return flashcardModel;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        _filepath = [documentsDirectory stringByAppendingPathComponent:kFlashcardsPList];
        // Confirming filepath leads to plist:
        //NSLog(_filepath);
        NSArray *arrAsDict = [[NSArray alloc] initWithContentsOfFile:self.filepath];
        
        if (arrAsDict.count != 0){
            NSMutableArray *arrayConvertedToFlashcards = [[NSMutableArray alloc] init];
            for (NSDictionary *dictionaryCard in arrAsDict){
                Flashcard *convertedCard = [[Flashcard alloc] initFromDictionary:dictionaryCard];
                [arrayConvertedToFlashcards addObject:convertedCard];
            }
            _flashcards = arrayConvertedToFlashcards;
        }
        
        else{
            Flashcard *flashcard0 = [[Flashcard alloc] initWithQuestion:@"What is the tallest mountain in the world?" answer:@"Mount Everest."];
            
            Flashcard *flashcard1 = [[Flashcard alloc] initWithQuestion:@"What is the tallest animal in the world?" answer:@"Giraffes."];
            
            Flashcard *flashcard2 = [[Flashcard alloc] initWithQuestion:@"What is the tallest building in the world?" answer:@"Burj Khalifa."];
            
            Flashcard *flashcard3 = [[Flashcard alloc] initWithQuestion:@"Who is the tallest living person in the world?" answer:@"Sultan Kosen, 8ft 2.8in."];
            
            Flashcard *flashcard4 = [[Flashcard alloc] initWithQuestion:@"What is the tallest tree in the world?" answer:@"Redwoods."];
            
            _flashcards = [[NSMutableArray alloc] initWithObjects:flashcard0, flashcard1, flashcard2, flashcard3, flashcard4, nil];
            
            _currentIndex = 0;
        }
    }
    
    return self;
}

- (NSUInteger) numberOfFlashcards{
    return self.flashcards.count;
}

- (Flashcard *) randomFlashcard{
    int randomIndex = (int)arc4random_uniform((uint32_t)self.flashcards.count);
    _currentIndex = randomIndex;
    return self.flashcards[self.currentIndex];
}

- (Flashcard *) flashcardAtIndex: (NSUInteger)index{
    if (index > self.flashcards.count) {
        NSLog(@"Invalid index");
        return NULL;
    }
    
    else{
        _currentIndex = index;
        return self.flashcards[self.currentIndex];
    }
}

- (Flashcard *) nextFlashcard{
    int test = self.currentIndex + 1;
    if (test >= self.flashcards.count)
    {
        NSLog(@"Invalid index");
        return NULL;
    }
    
    else{
        _currentIndex += 1;
        return self.flashcards[self.currentIndex];
    }
}

- (Flashcard *) prevFlashcard{
    int test = self.currentIndex - 1;
    if (test < 0)
    {
        NSLog(@"Invalid index");
        return NULL;
    }
    
    else{
        _currentIndex -= 1;
        return self.flashcards[self.currentIndex];
    }
}

- (void) insertWithQuestion: (NSString *) question
                     answer: (NSString *) ans
                   favorite: (BOOL)fav{
    Flashcard *newFlashcard = [[Flashcard alloc] initWithQuestion:question answer:ans isFavorite:fav];
    [self.flashcards addObject:newFlashcard];
    [self save];
    }

- (void) insertWithQuestion: (NSString *) question
                     answer: (NSString *) ans
                   favorite: (BOOL) fav
                    atIndex: (NSUInteger) index{
    Flashcard *newFlashcard = [[Flashcard alloc] initWithQuestion:question answer:ans isFavorite:fav];
    [self.flashcards insertObject:newFlashcard atIndex:index];
    [self save];
}

- (void) removeFlashcard{
    [self.flashcards removeLastObject];
    [self save];
}

- (void) removeFlashcardAtIndex: (NSUInteger) index{
    if (index < self.flashcards.count){
        [self.flashcards removeObjectAtIndex:index];
    }
    else{
        NSLog(@"Invalid index");
    }
    [self save];
}

- (void) toggleFavorite{
    Flashcard *testCard = self.flashcards[self.currentIndex];
    if (testCard.isFavorite)
    {
        testCard.isFavorite = NO;
    }
    else{
        testCard.isFavorite = YES;
    }
    
    [self.flashcards replaceObjectAtIndex:self.currentIndex withObject:testCard];
}

- (NSArray *) favoriteFlashcards{
    NSMutableArray *favoriteFlashcards;
    favoriteFlashcards = [[NSMutableArray alloc] init];
    for (int i = 0; i < self.flashcards.count; i++)
    {
        Flashcard *testCard = self.flashcards[i];
        if (testCard.isFavorite)
        {
            [favoriteFlashcards addObject:testCard];
        }

    }
    
    return favoriteFlashcards;
}

- (void)save{
    // want array of dictionaries from flashcards array
    // create and alloc/init a mutable array
    NSMutableArray *flashcardsAsDictionaries = [[NSMutableArray alloc] init];
    // instance of flashcard
    Flashcard *singleCard;
    // loop through flashcards and call convertFlashcardToDictionary on each one
    for (singleCard in self.flashcards) {
        [flashcardsAsDictionaries addObject:[singleCard convertFlashcardToDictionary:singleCard]];
    }
    // write to the plist file
    [flashcardsAsDictionaries writeToFile:self.filepath atomically:YES];
}

@end


