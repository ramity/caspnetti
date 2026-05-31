#!/bin/bash

if [ -z "$1" ]; then
    echo "Usage: $0 <replacement_string>"
    exit 1
fi

export NEW_VAL="$1"
export OLD_VAL="Caspnetti"

echo "Step 1: Renaming Directories and Files..."

# We use a length-based sort to rename children before parents
# This ensures ./dir/file.txt is handled before ./dir/
find . -path "./.git" -prune -o -iname "*${OLD_VAL}*" -print | awk '{ print length, $0 }' | sort -rn | cut -d" " -f2- | while read -r path; do
    
    dir=$(dirname "$path")
    base=$(basename "$path")
    
    # We use Perl with | as a delimiter to avoid path clash
    # The logic correctly catches Caspnetti.API -> Caspnetti.API
    new_base=$(echo "$base" | perl -pe '
        s|('"$OLD_VAL"')|
            $m = $1; 
            $r = $ENV{NEW_VAL};
            if ($m =~ /^[A-Z][A-Z]+$/) { uc($r) }
            elsif ($m =~ /^[A-Z]/) { ucfirst($r) }
            else { lc($r) }
        |gie')
    
    if [ "$base" != "$new_base" ]; then
        # Ensure we don't move a file into a non-existent path 
        # (though the length-sort usually prevents this)
        mv "$path" "$dir/$new_base"
        echo "Renamed: $path -> $dir/$new_base"
    fi
done

echo "Step 2: Updating File Contents..."

# Target files only, skipping .git
find . -path "./.git" -prune -o -type f -exec grep -il "$OLD_VAL" {} + | while read -r file; do
    # Perform case-aware substitution
    # Lower: wry -> wry
    sed -i "s/${OLD_VAL}/${NEW_VAL,,}/g" "$file"
    # Title: Wry -> Wry
    sed -i "s/${OLD_VAL^}/${NEW_VAL^}/g" "$file"
    # Upper: WRY -> WRY
    sed -i "s/${OLD_VAL^^}/${NEW_VAL^^}/g" "$file"
done

echo "Operation complete."
