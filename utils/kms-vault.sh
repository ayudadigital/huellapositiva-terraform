#!/usr/bin/env bash
#
# Usage:
#
# Encrypt a file:
# kms-vault encrypt My-Key-Alias some-file-i-want-encrypted.txt [AWS region] > topsecret.asc
#
# Decrypt a file:
# kms-vault decrypt topsecret.asc [AWS region]
#
# Encrypt a string:
# kms-vault encrypt_string <My-Key-Alias> "text to encrypt" [AWS region]
#
# Decrypt a string:
# kms-vault decrypt_string "ciphertext" [AWS region]
#
# Get alias of the key used to encrypt a file:
# kms-vault print-kms-alias topsecret.asc [AWS region]
#

#
# Requirements: AWS CLI, jq
#
# Your AWS profile / default profile needs to have access to the KMS key you want to use
# and the kms:ListAliases permission.
#

set -eu -o pipefail

command=$1

function getKeyId {
    key_alias="$1"
    key_info=$(aws kms ${aws_region_subcommand} list-aliases | jq -r ".Aliases[] | select(.AliasName | contains (\"$key_alias\"))")
    echo "Using key:" 1>&2
    echo "$key_info" | jq 1>&2
    key_id=$(echo "$key_info" | jq -r .TargetKeyId)
    echo ${key_id}
}

function getKeyAlias {
  key_id="$1"
  key_info=$(aws kms ${aws_region_subcommand} list-aliases --key-id $key_id | jq -r ".Aliases[]")
  key_alias=$(echo "$key_info" | jq -r .AliasName | awk -F  "/" '{print $2}')
  echo "$key_alias"
}

if [[ $command = "encrypt" ]]; then
    key_alias="$2"
    plaintext_path="$3"

    aws_region_subcommand=""
    if [ ! -z ${4:-""} ]; then
        aws_region_subcommand="--region ${4}"
    fi

    key_id=$(getKeyId ${key_alias})
    aws kms encrypt ${aws_region_subcommand} --key-id "$key_id" --plaintext "fileb://$plaintext_path" --query CiphertextBlob --output text
    exit 0
elif [[ $command = "decrypt" ]]; then
    ciphertext_path="$2"

    aws_region_subcommand=""
    if [ ! -z ${3:-""} ]; then
        aws_region_subcommand="--region ${3}"
    fi

    aws kms ${aws_region_subcommand} decrypt --ciphertext-blob fileb://<(cat $ciphertext_path | base64 --decode) --output text --query Plaintext | base64 --decode
    exit 0
elif [[ $command = "encrypt_string" ]]; then
    key_alias="$2"
    plaintext="$3"

    aws_region_subcommand=""
    if [ ! -z ${4:-""} ]; then
        aws_region_subcommand="--region ${4}"
    fi

    key_id=$(getKeyId ${key_alias})
    aws kms encrypt ${aws_region_subcommand} --cli-binary-format raw-in-base64-out --key-id "$key_id" --plaintext "$plaintext" --query CiphertextBlob --output text
    echo
    exit 0
elif [[ $command = "decrypt_string" ]]; then
    ciphertext="$2"

    aws_region_subcommand=""
    if [ ! -z ${3:-""} ]; then
        aws_region_subcommand="--region ${3}"
    fi

    aws kms ${aws_region_subcommand} decrypt --ciphertext-blob fileb://<(echo ${ciphertext} | base64 --decode) --output text --query Plaintext | base64 --decode
    echo
    exit 0
elif [[ $command = "print-kms-alias" ]]; then
    ciphertext_path="$2"

    aws_region_subcommand=""
    if [ ! -z ${3:-""} ]; then
        aws_region_subcommand="--region ${3}"
    fi

    key_id=$(aws kms ${aws_region_subcommand} decrypt --ciphertext-blob fileb://<(cat $ciphertext_path | base64 --decode) --output text --query KeyId)
    echo "Alias: $(getKeyAlias "$key_id")"
    exit 0
else
    echo "Unknown command: $command"
    exit 1
fi
