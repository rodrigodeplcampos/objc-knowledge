//
//  ForwardDeclaration.h
//  ObjectiveCKnowledge
//
//  Created by Rodrigo De Paula on 15/07/2018.
//  Copyright © 2018 None. All rights reserved.
//

#import <Foundation/Foundation.h>
//  2) These are the only situations when the class/protocol can't be forward-declared because the compiler needs to know all the methods in the protocol and the super class structure.
//  For that reason, having more than one protocol/class definition per file is a bad practice since that the whole file would be imported in that case.
//  Consider moving the protocol conformance to a category extension of the class
#import "ForwardDeclarationProtocol.h"
#import "ForwardDeclarationSuper.h"

//  1) This is called forward declaration.
//  When the definition of a type is required in the .h file, the compiler only needs to know that the class/protocol exists so an import is not needed.
//  Doing so, the compile time can be significantly reduced and in an import chain, only what is needed will be imported.
//  It also helps when there is a circular dependancy between two classes.
@class GeneralObjC;

@interface ForwardDeclaration : ForwardDeclarationSuper <ForwardDeclarationProtocol>

@property (nonatomic, strong) GeneralObjC *generalObjC;

@end
