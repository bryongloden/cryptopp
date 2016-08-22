#! /usr/bin/env bash

if [ "$#" -eq "0" ];then
	echo "No files selected"
	[ "$0" = "$BASH_SOURCE" ] && exit 0 || return 0
fi

IS_OSX=$(uname -s | grep -i -c darwin)
if [[ "$IS_OSX" -ne "0" ]]; then
	SED=(sed -i "")
else
	SED=(sed -i)
fi

for argv in "$@"
do
	# Fold two into one
	"${SED[@]}" 's/CRYPTOPP_BOOL_SSE2_ASM_AVAILABLE || CRYPTOPP_BOOL_SSE2_INTRINSICS_AVAILABLE/CRYPTOPP_BOOL_SSE2_AVAILABLE/g' "$argv"
	"${SED[@]}" 's/CRYPTOPP_BOOL_SSE2_INTRINSICS_AVAILABLE || CRYPTOPP_BOOL_SSE2_ASM_AVAILABLE/CRYPTOPP_BOOL_SSE2_AVAILABLE/g' "$argv"

	# Replace _ASM and _INTRINSICS
	"${SED[@]}" 's|CRYPTOPP_BOOL_SSE2_ASM_AVAILABLE|CRYPTOPP_BOOL_SSE2_AVAILABLE|g' "$argv"
	"${SED[@]}" 's|CRYPTOPP_BOOL_SSE2_INTRINSICS_AVAILABLE|CRYPTOPP_BOOL_SSE2_AVAILABLE|g' "$argv"	
	"${SED[@]}" 's|CRYPTOPP_BOOL_SSE4_INTRINSICS_AVAILABLE|CRYPTOPP_BOOL_SSE4_AVAILABLE|g' "$argv"	
	"${SED[@]}" 's|CRYPTOPP_BOOL_AESNI_INTRINSICS_AVAILABLE|CRYPTOPP_BOOL_AESNI_AVAILABLE|g' "$argv"
	"${SED[@]}" 's|CRYPTOPP_BOOL_NEON_INTRINSICS_AVAILABLE|CRYPTOPP_BOOL_NEON_AVAILABLE|g' "$argv"
	"${SED[@]}" 's|CRYPTOPP_BOOL_ARM_CRYPTO_INTRINSICS_AVAILABLE|CRYPTOPP_BOOL_ARM_CRYPTO_AVAILABLE|g' "$argv"
	"${SED[@]}" 's|CRYPTOPP_BOOL_ARM_CRC32_INTRINSICS_AVAILABLE|CRYPTOPP_BOOL_ARM_CRC32_AVAILABLE|g' "$argv"

	unix2dos --keepdate --quiet "$argv"
done

[ "$0" = "$BASH_SOURCE" ] && exit 0 || return 0
