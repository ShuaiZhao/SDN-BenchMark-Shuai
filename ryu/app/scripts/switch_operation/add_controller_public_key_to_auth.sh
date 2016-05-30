#!/bin/bash
# add_controller_public_key_to_auth.sh
public_key='xxxx'

cat >> ~/.ssh/authorized_keys << EOF
$public_key
EOF