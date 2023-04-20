# BIP39
[![Build Status](https://travis-ci.org/pengpengliu/BIP39.svg)](https://travis-ci.org/pengpengliu/BIP39) 
[![codecov](https://codecov.io/gh/pengpengliu/BIP39/branch/master/graph/badge.svg)](https://codecov.io/gh/pengpengliu/BIP39)

Swift implementation of Bitcoin [BIP39](https://github.com/bitcoin/bips/blob/master/bip-0039.mediawiki). [#PureSwift](https://twitter.com/hashtag/pureswift)

```swift
// Generating the mnemonic, defaults to english wordlist and 128-bits of entropy
let random = Mnemonic()

// Initialize with seed phrase and passphrase
let mnemonic = Mnemonic(phrase: "rally speed budget undo purpose orchard hero news crunch flush wine finger".components(separatedBy: " "), passphrase: "")

// From mnemonic to seed
let seed = mnemonic.seed
```

## License
Code is under the [BSD 2-clause "Simplified" License](LICENSE.txt).
Documentation is under the [Creative Commons Attribution license](https://creativecommons.org/licenses/by/4.0/).
