#!/bin/bash

set -e

install() {

  #
  # Install missing packages 
  # 
  sudo apt-get update --fix-missing
  sudo apt-get install -y wget nano curl ncbi-blast+

  sudo apt-get install -y python-numpy
  sudo apt-get install -y python-biopython
  sudo apt-get install -y probalign
  
  # Downgrade Python 2.7 to Python 2.6
  #sudo apt-get install -y python-software-properties
  #sudo add-apt-repository ppa:fkrull/deadsnakes -y
  #sudo apt-get update -y 
  #sudo apt-get install -y python2.6 python2.6-dev
  #sudo rm -rf /usr/bin/python
  #sudo ln -s /usr/bin/python2.6 /usr/bin/python
  
  #
  # Install T-Coffee 
  # 
  wget -q -r -l1 --no-parent -A "T-COFFEE_installer*_linux_x64.bin" http://tcoffee.org/Packages/Beta/Latest/linux/
  tcoffee=`ls tcoffee.org/Packages/Beta/Latest/linux/*.bin`
  chmod +x $tcoffee
  $tcoffee --mode unattended --user_email tcoffee.msa@gmail.com
  rm -rf tcoffee.org
  
  #
  # Install X3DNA -- http://x3dna.org/
  # 
  wget -q http://www.tcoffee.org/Packages/Archive/X3DNA/Linux_x86-64_X3DNA_v2.0.tar.gz
  tar xf Linux_x86-64_X3DNA_v2.0.tar.gz
  printf '\nexport PATH=$HOME/X3DNA/bin:$PATH\n' >> .profile 
  rm -rf Linux_x86-64_X3DNA_v2.0.tar.gz

  #
  # Install SARA  -- http://structure.biofold.org/sara/
  #  
  wget -q http://structure.uib.es/sara/pages/versions/sara-1.0.7.tar.gz
  tar xvf sara-1.0.7.tar.gz 
  sed -i "s@^x3dna=.*@x3dna=$HOME/X3DNA/bin/find_pair@" ~/sara-1.0.7/Tools/ENVIRON 
  printf 'export PATH=$HOME/sara-1.0.7:$PATH\n' >> ~/.profile 
  rm -rf sara-1.0.7.tar.gz 
  
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
