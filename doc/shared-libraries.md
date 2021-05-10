Shared Libraries
================

## Kronconsensus

The purpose of this library is to make the verification functionality that is critical to Kron's consensus available to other applications, e.g. to language bindings.

### API

The interface is defined in the C header `Kronconsensus.h` located in  `src/script/Kronconsensus.h`.

#### Version

`Kronconsensus_version` returns an `unsigned int` with the API version *(currently at an experimental `0`)*.

#### Script Validation

`Kronconsensus_verify_script` returns an `int` with the status of the verification. It will be `1` if the input script correctly spends the previous output `scriptPubKey`.

##### Parameters
- `const unsigned char *scriptPubKey` - The previous output script that encumbers spending.
- `unsigned int scriptPubKeyLen` - The number of bytes for the `scriptPubKey`.
- `const unsigned char *txTo` - The transaction with the input that is spending the previous output.
- `unsigned int txToLen` - The number of bytes for the `txTo`.
- `unsigned int nIn` - The index of the input in `txTo` that spends the `scriptPubKey`.
- `unsigned int flags` - The script validation flags *(see below)*.
- `Kronconsensus_error* err` - Will have the error/success code for the operation *(see below)*.

##### Script Flags
- `Kronconsensus_SCRIPT_FLAGS_VERIFY_NONE`
- `Kronconsensus_SCRIPT_FLAGS_VERIFY_P2SH` - Evaluate P2SH ([BIP16](https://github.com/Kron/bips/blob/master/bip-0016.mediawiki)) subscripts
- `Kronconsensus_SCRIPT_FLAGS_VERIFY_DERSIG` - Enforce strict DER ([BIP66](https://github.com/Kron/bips/blob/master/bip-0066.mediawiki)) compliance
- `Kronconsensus_SCRIPT_FLAGS_VERIFY_NULLDUMMY` - Enforce NULLDUMMY ([BIP147](https://github.com/Kron/bips/blob/master/bip-0147.mediawiki))
- `Kronconsensus_SCRIPT_FLAGS_VERIFY_CHECKLOCKTIMEVERIFY` - Enable CHECKLOCKTIMEVERIFY ([BIP65](https://github.com/Kron/bips/blob/master/bip-0065.mediawiki))
- `Kronconsensus_SCRIPT_FLAGS_VERIFY_CHECKSEQUENCEVERIFY` - Enable CHECKSEQUENCEVERIFY ([BIP112](https://github.com/Kron/bips/blob/master/bip-0112.mediawiki))
- `Kronconsensus_SCRIPT_FLAGS_VERIFY_WITNESS` - Enable WITNESS ([BIP141](https://github.com/Kron/bips/blob/master/bip-0141.mediawiki))

##### Errors
- `Kronconsensus_ERR_OK` - No errors with input parameters *(see the return value of `Kronconsensus_verify_script` for the verification status)*
- `Kronconsensus_ERR_TX_INDEX` - An invalid index for `txTo`
- `Kronconsensus_ERR_TX_SIZE_MISMATCH` - `txToLen` did not match with the size of `txTo`
- `Kronconsensus_ERR_DESERIALIZE` - An error deserializing `txTo`
- `Kronconsensus_ERR_AMOUNT_REQUIRED` - Input amount is required if WITNESS is used

### Example Implementations
- [NKron](https://github.com/NicolasDorier/NKron/blob/master/NKron/Script.cs#L814) (.NET Bindings)
- [node-libKronconsensus](https://github.com/bitpay/node-libKronconsensus) (Node.js Bindings)
- [java-libKronconsensus](https://github.com/dexX7/java-libKronconsensus) (Java Bindings)
- [Kronconsensus-php](https://github.com/Bit-Wasp/Kronconsensus-php) (PHP Bindings)
