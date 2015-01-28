//
//  BTPasswordSeed.m
//  bitheri
//
//  Copyright 2014 http://Bither.net
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.

#import "BTPasswordSeed.h"
#import "BTQRCodeUtil.h"
#import "BTEncryptedData.h"

@interface BTPasswordSeed ()

@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *keyStr;

@end

@implementation BTPasswordSeed

- (instancetype)initWithAddress:(NSString *)address andEncryptStr:(NSString *)encryptStr; {
    if (!(self = [super init])) return nil;

    self.address = address;
    self.keyStr = encryptStr;

    return self;
}

- (instancetype)initWithString:(NSString *)message {
    self = [super init];
    if (self) {
        NSArray *array = [BTQRCodeUtil splitQRCode:message];
        NSString *addressString = array[0];
        if ([BTQRCodeUtil isOldQRCodeVerion:message]) {
            _address = addressString;
        } else {
            _address = [addressString hexToBase58check];
        }

        _keyStr = [message substringFromIndex:addressString.length + 1];

    }
    return self;
}

- (instancetype)initWithBTAddress:(BTAddress *)btAddress {
    if (!(self = [super init])) return nil;

    if (btAddress.encryptPrivKeyForCreate == nil)
        return nil;

    _address = btAddress.address;
    _keyStr = [BTEncryptedData encryptedString:btAddress.encryptPrivKeyForCreate
                               addIsCompressed:btAddress.isSyncComplete andIsXRandom:btAddress.isFromXRandom];

    return self;
}

- (BOOL)checkPassword:(NSString *)password {
    BTKey *key = [BTKey keyWithBitcoinj:self.keyStr andPassphrase:password];
    if (key) {
        return [key.address isEqualToString:self.address];
    } else {
        return NO;
    }
}

- (NSString *)toPasswordSeedString {
    NSArray *array = @[[self.address base58checkToHex], self.keyStr];
    return [[BTQRCodeUtil joinedQRCode:array] toUppercaseStringWithEn];
}


@end
