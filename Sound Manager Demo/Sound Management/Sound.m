//
//  Sound.m
//  Sound Manager Demo
//
//  Created by Michael MacCallum on 1/13/16.
//  Copyright © 2016 Michael MacCallum. All rights reserved.
//

#import "Sound.h"

@interface Sound ()

@property (strong, nonatomic, readwrite) NSURL * _Nonnull filePath;

@end

@implementation Sound

- (_Nonnull instancetype)initWithUrl:(NSURL *)filePath
{
    if (self = [super init]) {
        [self setFilePath:filePath];
    }
    
    return self;
}

- (NSString * _Nullable)fileName
{
    return [[self.filePath lastPathComponent] stringByDeletingPathExtension];
}

- (NSString * _Nullable)fileExtension
{
    return [self.filePath pathExtension];
}

- (BOOL)isEqual:(id)object
{
    if (self == object) {
        return YES;
    }
    
    if (![object isKindOfClass:[Sound class]]) {
        return NO;
    }
    
    return [self.filePath isEqual:((Sound *)object).filePath];
}

@end
