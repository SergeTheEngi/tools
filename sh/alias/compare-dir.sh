#! /bin/sh

# Recursively compares contents of two directories. Made to be loaded via bashrc or analogue.
# Thanks Adail Junior (https://stackexchange.com/users/3625606/adail-junior)!

compare-dir(){ # compare-dir <dir1> <dir2>
   diff <(find "$1" -type f -exec md5sum {} + | sort -k 2 | sed 's/ .*\// /') <(find "$2" -type f -exec md5sum {} + | sort -k 2 | sed 's/ .*\// /')
}
