//
//  GeneralObjC.m
//  ObjectiveCKnowledge
//
//  Created by Rodrigo De Paula on 15/07/2018.
//  Copyright © 2018 None. All rights reserved.
//
//  Objective-c messaging structure with dynamic binding: The runtime decides which code gets executed as opposed to the compiler.

#import "GeneralObjC.h"

//  This should replace #define INTERNAL_INT because the static const has a type and any other class that imports the header file on which the #define is declared, will replace INTERNAL_INT as well.
//  k is a suffix to indicate that the constant is locally declared. If it's a global constant, the prefix should be the class name and the declaration will be moved to the .h file. Only expose the constants that MUST be exposed.
//  It's important that the variable is static and const. Const means that the compiler won't allow someone else to try to modify its value and static means that the symbol will be created in the generated .o file as opposed to in a global symbol table, which can avoid a "duplicate symbols" compile crash. Saying so, it will only replace the local occurences of kInternalInt with the 0 value as the #define would do but with the correct type instead.
static const int kInternalInt = 0;

//  The declaration is read backwards meaning that this is a constant pointer to a string, meaning that this pointer cannot point to a different string.
//  Because there is no static modifier, this symbol will be created in the global symbol table.
NSString *const OCKGeneralObjCExternalString = @"external string";

//  The following two macros to declare enums are used to define an enum with an associated value type, backwards compatible with different compiler versions.
typedef NS_ENUM(NSUInteger, MyEnumOfTypes) {
    MyEnumOfTypesTypeOne,
    MyEnumOfTypesTypeTwo,
    MyEnumOfTypesTypeThree
};

//  This enum is a bitmask and should be used to express a situation when more than one value can coexist.
typedef NS_OPTIONS(NSInteger, MyBitMaskEnum) {
    MyBitMaskEnumFirstOption    = 1 << 0,
    MyBitMaskEnumSecondOption   = 1 << 1,
    MyBitMaskEnumThirdOption    = 1 << 2,
    MyBitMaskEnumFourthOption   = 1 << 3
};

@implementation GeneralObjC

//  Memory allocation for ObjC objects is always in heap space and never on the stack
- (void)heapVsStackExample {
    NSString *myFirstString = @"text";
    NSString *mySecondString = myFirstString; // This is a pointer that references the first string thus is not a copy
    
    // Stack: myFirstString | mySecondString
    // Heap: @"text" object
    
    int myFirstInt = 0;
    
    // Stack: myFirstString | mySecondString | myFirstInt
    // Heap: @"text" object
    
    // Creating objects incurs overhead such as allocating and deallocating heap memory. Prefer structs over classes when the entity can be defined using purely primitive types
}

//  Literals make the NSNumber syntax much clearer and easier to read
- (NSNumber *)sum:(int)first second:(float)second {
    return @(first + second);
}

- (void)literalsInCollections {
    //  The insertion of a nil object in a literal array is safer because it will crash the app. When using the verbose native syntax, the insertion of the same element may lead to an array with fewer elements than expected which is a bug much harder to spot than a crash.
    NSArray *literalSyntaxArray = @[@1, @2.5f, @YES];
    BOOL boolFromArray = literalSyntaxArray[2];
    
    //  This is particular easy to read since that it follows the key/value declaration order as opposed to the native dictionaryWithObjectsAndKeys: method
    NSDictionary *literalSyntaxDictionary = @{@"firstItem":@"a string",
                                              @"secondItem":@4,
                                              @"thirdItem":@(boolFromArray)};
    
    NSString *firstItem = literalSyntaxDictionary[@"firstItem"];
    
    NSMutableArray *literalSyntaxMutableArray = [@[@1,@2,@3] mutableCopy];
    literalSyntaxMutableArray[0] = @0;
    
    NSMutableDictionary *literalSyntaxMutableDictionary = [@{@"firstItem":@"one",
                                                            @"secondItem":@"two",
                                                            @"thirdItem":@"three"} mutableCopy];
    literalSyntaxMutableDictionary[@"firstItem"] = firstItem;
}

- (BOOL)bitmaskEnum {
    //  The bitwise OR operator is used to encode the coexistent values. Ex: 001 | 100 = 101
    MyBitMaskEnum bitmaskEnum = MyBitMaskEnumFirstOption | MyBitMaskEnumThirdOption;
    
    //  The bitwise AND operator is used to decode the coexistent values. Ex: 101 & 100 = 100 (true)
    return bitmaskEnum & MyBitMaskEnumThirdOption;
}

- (void)regularEnum:(MyEnumOfTypes)enumOfTypes {
    //  Using the default in the switch/case is not recommended because if a new case is added to the enum, the default case will handle that silently whether if there is no default, the compiler will warn about the unhandled scenario.
    switch (enumOfTypes) {
        case MyEnumOfTypesTypeOne:
            NSLog(@"Case type one handled");
            break;
        case MyEnumOfTypesTypeTwo:
            NSLog(@"Case type two handled");
            break;
        case MyEnumOfTypesTypeThree:
            NSLog(@"Case type three handled");
            break;
    }
}



@end
