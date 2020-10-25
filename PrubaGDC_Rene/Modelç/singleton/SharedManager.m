//
//  SharedManager.m
//  PrubaGDC_Rene
//
//  Created by Prueba IOS on 10/24/20.
//

#import "SharedManager.h"

@implementation MyManager

@synthesize someProperty;

#pragma mark Singleton Methods

+ (id)sharedManager {
    static MyManager *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

- (id)init {
  if (self = [super init]) {
  }
  return self;
}

- (void)dealloc {
  // Should never be called, but just here for clarity really.
}

@end
