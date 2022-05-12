#! /bin/bash 

gpg_setup(){
gpg --full-generate-key
keygen=$(gpg --list-secret-keys --keyid-format=long|awk '/sec/{if (length($2)>0) print $2}');
IFS=''  
read -ra keyarr1 <<<"$keygen"
len=${#keyarr1[@]} 
keyspli=${keyarr1[len-1]}
IFS='/'  
read -a keyarr2 <<<"$keyspli"
key=${keyarr[1]}

git config --global user.signingkey $key
git config --global commit.gpgsign true
gpg --armor --export $key
echo
echo "Copy your GPG key, beginning with -----BEGIN PGP PUBLIC KEY BLOCK----- and ending with -----END PGP PUBLIC KEY BLOCK-----"
echo "Add the GPG key to your GitHub account."
echo
echo "Thanks for using us"

}
keygen=$(gpg --list-secret-keys --keyid-format=long|awk '/sec/{if (length($2)>0) print $2}');
IFS='/'  
read -a keyarr <<<"$keygen"
key=${keyarr[1]}
if [ -n key ];

then
    echo "A GPG KEY ALREADY EXISTS ON YOUR SYSTEM"
    read -p "Do you still want to make new a one and set it as signingkey(y/n): " choice
    if [ $choice == "y" ]; then
        gpg_setup
    else  
          read -p "Do you want to set signingkey(y/n): " choice2
          if [ $choice2 == "y" ]; then
                 gpg --list-secret-keys --keyid-format=long
                 read -p "Give your keyID to set as Signingkey: " sigkey
                 git config --global user.signingkey $sigkey
                 git config --global commit.gpgsign true
                 echo "Thanks for using us"
          else   
          echo "Thanks for using us"
          fi
    fi

else
gpg_setup
fi
