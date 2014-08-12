#!/bin/bash

set -e

install() {

  #
  # Install missing packages 
  # 
  sudo apt-get update --fix-missing
  sudo apt-get install -y wget nano curl unzip

  sudo apt-get install -y python-numpy
  sudo apt-get install -y python-biopython
  
  #
  # Install T-Coffee 
  # 
  wget -q -r -l1 --no-parent -A "T-COFFEE_installer*_linux_x64.bin" http://tcoffee.org/Packages/Stable/Latest/linux/
  tcoffee=`ls tcoffee.org/Packages/Stable/Latest/linux/*.bin`
  chmod +x $tcoffee
  $tcoffee --mode unattended --user_email tcoffee.msa@gmail.com
  rm -rf tcoffee.org
  
  # Download PDB structure list
  mkdir -p ~/.t_coffee/cache
  cd ~/.t_coffee/cache
  wget -q ftp://ftp.wwpdb.org/pub/pdb/derived_data/pdb_entry_type.txt 
  cd -
  
  #
  # Install X3DNA -- http://x3dna.org/
  # 
  wget -q http://www.tcoffee.org/Packages/Archive/X3DNA/Linux_x86-64_X3DNA_v2.0.tar.gz
  tar xf Linux_x86-64_X3DNA_v2.0.tar.gz
  printf '\n' >> .profile 
  printf 'export X3DNA=$HOME/X3DNA\n' >> .profile 
  printf 'export PATH=$X3DNA/bin:$PATH\n' >> .profile 
  rm -rf Linux_x86-64_X3DNA_v2.0.tar.gz

  #
  # Install SARA  -- http://structure.biofold.org/sara/
  #  
  wget -q http://www.tcoffee.org/Packages/Archive/sara-1.0.7_patched.zip
  unzip -q sara-1.0.7_patched.zip
  sed -i "s@^x3dna=.*@x3dna=$HOME/X3DNA/bin/find_pair@" ~/sara-1.0.7/Tools/ENVIRON 
  printf 'export PATH=$HOME/sara-1.0.7:$PATH\n' >> ~/.profile 
  printf 'export PATH=$HOME/sara-1.0.7/Utils/:$PATH\n' >> ~/.profile
  # copy sara patch 
  cp /vagrant/out3dna.py $HOME/sara-1.0.7/Utils/
  chmod +x $HOME/sara-1.0.7/Utils/*.py
  rm -rf sara-1.0.7_patched.zip 
  

  
  # Append T-coffee plugins to PATH
  printf 'export PATH=$DIR_4_TCOFFEE/plugins/linux:$PATH\n' >> ~/.profile 
  
  #
  # Download SARA-COFFE-PACKAGE
  # 
  wget -q http://www.tcoffee.org/Projects/saracoffee/sara_coffee_package.tar.gz 
  tar xf sara_coffee_package.tar.gz
  rm sara_coffee_package.tar.gz
  cp /vagrant/sara_coffee.sh sara_coffee_package/
  
  #
  # Test SARA
  # 
  cd $HOME/sara-1.0.7
  ./runsara.py Test/pdb1q96.ent A Test/pdb1u6b.ent B -b -s
  
  
} 


# Exit if already bootstrapped.
test -f /etc/bootstrapped && exit

export -f install
su vagrant -c 'install'

# Mark as bootstrapped 
date > /etc/bootstrapped
