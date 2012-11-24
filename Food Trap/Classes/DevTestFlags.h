///
///  DevTestFlags.m
///  sams_club
///
///  Created by Steven Silvey on 1/19/12.
///  Copyright 2012 Rockfish. All rights reserved.
///


/// WHAT IS THIS FILE?
/// This file has a set of dev test flags that can be YES or NO.  They are used when you want to 
/// temporarily change the logic of the app.  For example, you may want to state you are at a given
/// location when you are not physically at that location.
///
/// But, we don't want something that is intended soley for testing to sneak its way into QA or 
/// worse, production!  Thus, if PROVIDING_A_BUILD is set to THIS_WILL_BE_PROVIDED, all devtest flags
/// are forced to NO

///////////////////////////////////////////////////////
/// PROVIDING_A_BUILD is defined in BuildSettings.h ///
///////////////////////////////////////////////////////
#define THIS_WILL_NOT_BE_PROVIDED 0
#define THIS_WILL_BE_PROVIDED 1
#define PROVIDING_A_BUILD THIS_WILL_NOT_BE_PROVIDED
#if PROVIDING_A_BUILD == THIS_WILL_BE_PROVIDED
#define USE_THIS_DEVTEST_FLAG(_a)				(NO && _a)
#else
#define USE_THIS_DEVTEST_FLAG(_a)				(YES && _a)
#endif
///////////////////////////////////////////////////////



///////////////////////////////////////////////////////
/// THE FLAGS START HERE!
///////////////////////////////////////////////////////



#define DEVTEST_FORCE_LIGHTS_ON						USE_THIS_DEVTEST_FLAG( YES )
