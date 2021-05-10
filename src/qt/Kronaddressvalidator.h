// Copyright (c) 2011-2014 The Bitcoin Core developers
// Copyright (c) 2017-2019 The Kron Core developers
// Distributed under the MIT software license, see the accompanying
// file COPYING or http://www.opensource.org/licenses/mit-license.php.

#ifndef Kron_QT_KronADDRESSVALIDATOR_H
#define Kron_QT_KronADDRESSVALIDATOR_H

#include <QValidator>

/** Base58 entry widget validator, checks for valid characters and
 * removes some whitespace.
 */
class KronAddressEntryValidator : public QValidator
{
    Q_OBJECT

public:
    explicit KronAddressEntryValidator(QObject *parent);

    State validate(QString &input, int &pos) const;
};

/** Kron address widget validator, checks for a valid Kron address.
 */
class KronAddressCheckValidator : public QValidator
{
    Q_OBJECT

public:
    explicit KronAddressCheckValidator(QObject *parent);

    State validate(QString &input, int &pos) const;
};

#endif // Kron_QT_KronADDRESSVALIDATOR_H
