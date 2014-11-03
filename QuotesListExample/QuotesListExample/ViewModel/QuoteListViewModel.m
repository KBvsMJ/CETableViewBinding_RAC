//
//  QuoteListViewModel.m
//  QuotesListExample
//
//  Created by Colin Eberhardt on 30/10/2014.
//  Copyright (c) 2014 Colin Eberhardt. All rights reserved.
//

#import "QuoteListViewModel.h"
#import "QuoteViewModel.h"

@implementation QuoteListViewModel

- (instancetype)init {
  if (self = [super init]) {
   
    self.quotes = [[CEObservableMutableArray alloc] init];
    
    for (NSUInteger i=0; i<10; i++) {
      [self.quotes addObject:[self newQuote]];
    }
    
    [self performSelector:@selector(updatePrices) withObject:self afterDelay:1.0f];
  }
  return self;
}

- (void)updatePrices {
  [self performSelector:@selector(updatePrices) withObject:self afterDelay:1.0f];
  
  // remove the highlight
  for (QuoteViewModel *quote in self.quotes) {
    if (quote.highlight) {
      quote.highlight = NO;
    }
  }
  
  // randomly update some prices
  for (QuoteViewModel *quote in self.quotes) {
    if (RANDOM_DOUBLE > 0.7) {
      quote.price = @(quote.price.doubleValue + (RANDOM_DOUBLE * 10.0) - 5.0);
      quote.highlight = YES;
    }
  }
  
  // randomly add quotes
  if (RANDOM_DOUBLE > 0.8) {
    [self.quotes insertObject:[self newQuote] atIndex:2];
  }
}

NSString *letters = @"ABCDEFGHIJKLMNOPQRSTUVWXYZ";

- (QuoteViewModel *) newQuote {
  return [QuoteViewModel quoteWithSymbol:[self randomStringWithLength:4]];
}

-(NSString *) randomStringWithLength: (int) len {
  NSMutableString *randomString = [NSMutableString stringWithCapacity: len];
  for (int i=0; i<len; i++) {
    [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random_uniform([letters length])]];
  }
  return randomString;
}

@end
