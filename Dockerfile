FROM ubuntu:14.04

MAINTAINER Paolo Di Tommaso <paolo.ditommaso@gmail.com>

#
# Create the home folder 
#
RUN mkdir -p /root
ENV HOME /root

#
# Add missing packages
#
RUN apt-get update --fix-missing; \
  apt-get install -y wget nano curl unzip python-numpy python-biopython; 

#
# Download T-Coffee
#
RUN wget -q http://www.tcoffee.org/Packages/Archive/tcoffee-Version_10.00.r1613.tar.gz; \
  tar xf tcoffee-Version_10.00.r1613.tar.gz -C $HOME; \
  rm tcoffee-Version_10.00.r1613.tar.gz; 

#
# Download PDB entries file
# 
RUN mkdir -p $HOME/tcoffee/cache; \
  wget -q ftp://ftp.wwpdb.org/pub/pdb/derived_data/pdb_entry_type.txt -O $HOME/tcoffee/cache/pdb_entry_type.txt; 

#
# Install X3DNA
#
RUN wget -q http://www.tcoffee.org/Packages/Archive/X3DNA/Linux_x86-64_X3DNA_v2.0.tar.gz; \
  tar xf Linux_x86-64_X3DNA_v2.0.tar.gz -C $HOME; \
  rm Linux_x86-64_X3DNA_v2.0.tar.gz

#
# Installa SARA package
#
RUN wget -q http://www.tcoffee.org/Packages/Archive/sara-1.0.7_patched.zip; \
  unzip -q sara-1.0.7_patched.zip -d $HOME; \
  sed -i "s@^x3dna=.*@x3dna=$HOME/X3DNA/bin/find_pair@" $HOME/sara-1.0.7/Tools/ENVIRON; \
  rm sara-1.0.7_patched.zip

#
# Install Sara-COFFEE package 
#
RUN wget -q http://www.tcoffee.org/Projects/saracoffee/sara_coffee_package.tar.gz; \
  tar xf sara_coffee_package.tar.gz -C $HOME; \
  rm sara_coffee_package.tar.gz

#
# Some other magic scripts
#
ADD sara_coffee.sh /root/sara_coffee_package/
ADD out3dna.py /root/sara-1.0.7/Utils/

# Grant permissions 
RUN chmod +x $HOME/sara-1.0.7/Utils/*.py; \
  mv $HOME/tcoffee/plugins/linux/* $HOME/tcoffee/bin/

# 
# Finally config the environment 
#
ENV PATH /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/root/tcoffee/bin:/root/X3DNA/bin:/root/sara-1.0.7:/root/sara-1.0.7/Utils
ENV TEMP /tmp
ENV DIR_4_TCOFFEE /root/tcoffee
ENV EMAIL_4_TCOFFEE tcoffee.msa@gmail.com
ENV CACHE_4_TCOFFEE /root/tcoffee/cache/
ENV LOCKDIR_4_TCOFFEE /tmp/lck/
ENV TMP_4_TCOFFEE /tmp/
ENV X3DNA /root/X3DNA
