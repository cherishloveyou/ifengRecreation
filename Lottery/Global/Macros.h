//
//  Macros.h
//  Lottery
//
//  Created by August on 15/7/4.
//  Copyright (c) 2015年 August. All rights reserved.
//

#ifndef Lottery_Macros_h
#define Lottery_Macros_h

#define USERINFOARRAY @"userInfomationArray"
#define useInfoArray [[NSUserDefaults standardUserDefaults] arrayForKey:USERINFOARRAY]

#define USERINFODIC @"userInformationDictionary"
#define uerdictionary [[NSUserDefaults standardUserDefaults] dictionaryForKey:USERINFODIC]

#define currentFlag @"currentFlag"

#define CURRENTLOGINFLAG [[NSUserDefaults standardUserDefaults] stringForKey:currentFlag]

#endif
