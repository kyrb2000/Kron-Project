#!/bin/sh

TOPDIR=${TOPDIR:-$(git rev-parse --show-toplevel)}
SRCDIR=${SRCDIR:-$TOPDIR/src}
MANDIR=${MANDIR:-$TOPDIR/doc/man}

KronD=${KronD:-$SRCDIR/Krond}
KronCLI=${KronCLI:-$SRCDIR/Kron-cli}
KronTX=${KronTX:-$SRCDIR/Kron-tx}
KronQT=${KronQT:-$SRCDIR/qt/Kron-qt}

[ ! -x $KronD ] && echo "$KronD not found or not executable." && exit 1

# The autodetected version git tag can screw up manpage output a little bit
ESSVER=($($KronCLI --version | head -n1 | awk -F'[ -]' '{ print $6, $7 }'))

# Create a footer file with copyright content.
# This gets autodetected fine for Krond if --version-string is not set,
# but has different outcomes for Kron-qt and Kron-cli.
echo "[COPYRIGHT]" > footer.h2m
$KronD --version | sed -n '1!p' >> footer.h2m

for cmd in $KronD $KronCLI $KronTX $KronQT; do
  cmdname="${cmd##*/}"
  help2man -N --version-string=${ESSVER[0]} --include=footer.h2m -o ${MANDIR}/${cmdname}.1 ${cmd}
  sed -i "s/\\\-${ESSVER[1]}//g" ${MANDIR}/${cmdname}.1
done

rm -f footer.h2m
