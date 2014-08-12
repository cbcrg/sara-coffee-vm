FROM ubuntu:14.04

MAINTAINER Paolo Di Tommaso <paolo.ditommaso@gmail.com>

RUN apt-get update --fix-missing; apt-get install -y wget nano curl unzip python-numpy python-biopython

RUN wget -q http://www.tcoffee.org/Packages/Archive/tcoffee-Version_10.00.r1613.tar.gz; \
  tar xf tcoffee-Version_10.00.r1613.tar.gz -C /opt; \
  rm tcoffee-Version_10.00.r1613.tar.gz; 

RUN mkdir -p /tmp/cache; \
  wget -q ftp://ftp.wwpdb.org/pub/pdb/derived_data/pdb_entry_type.txt -O /tmp/cache/pdb_entry_type.txt; 

RUN wget -q http://www.tcoffee.org/Packages/Archive/X3DNA/Linux_x86-64_X3DNA_v2.0.tar.gz; \
  tar xf Linux_x86-64_X3DNA_v2.0.tar.gz -C /opt; \
  rm Linux_x86-64_X3DNA_v2.0.tar.gz

RUN wget -q http://www.tcoffee.org/Packages/Archive/sara-1.0.7_patched.zip; \
  unzip -q sara-1.0.7_patched.zip -d /opt; \
  sed -i "s@^x3dna=.*@x3dna=/opt/X3DNA/bin/find_pair@" /opt/sara-1.0.7/Tools/ENVIRON; \
  rm sara-1.0.7_patched.zip

RUN wget -q http://www.tcoffee.org/Projects/saracoffee/sara_coffee_package.tar.gz; \
  tar xf sara_coffee_package.tar.gz; \
  rm sara_coffee_package.tar.gz

ADD sara_coffee.sh /sara_coffee_package/
ADD out3dna.py /opt/sara-1.0.7/Utils/

RUN chmod +x /opt/sara-1.0.7/Utils/*.py

ENV X3DNA /opt/X3DNA
ENV PATH /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/tcoffee/bin:/opt/tcoffee/plugins/linux/:/opt/X3DNA/bin:/opt/sara-1.0.7:/opt/sara-1.0.7/Utils
ENV TEMP /tmp
ENV DIR_4_TCOFFEE /opt/tcoffee
ENV EMAIL_4_TCOFFEE tcoffee.msa@gmail.com
ENV CACHE_4_TCOFFEE /tmp/cache/
ENV LOCKDIR_4_TCOFFEE /tmp/lck/
ENV TMP_4_TCOFFEE /tmp/tmp/
