//
//  OCSAudioFromFSignal.m
//  Objective-C Sound
//
//  Created by Aurelius Prochazka on 7/22/12.
//  Copyright (c) 2012 Hear For Yourself. All rights reserved.
//

#import "OCSAudioFromFSignal.h"

@interface OCSAudioFromFSignal () {
    OCSFSignal *fSrc;
}
@end


@implementation OCSAudioFromFSignal


- (id)initWithSource:(OCSFSignal *)source;
{
    self = [super initWithString:[self operationName]];
    if (self) {
        fSrc = source;
    }
    return self; 
}

// Csound Prototype: ares pvsynth fsrc
- (NSString *)stringForCSD 
{
    return [NSString stringWithFormat:@"%@ pvsynth %@", self, fSrc];
}

@end
