SARA-COFFEE
===========

SARA-Coffee is a structure based multiple RNA aligner. 

This is a new algorithm that joins the pairwise RNA structure alignments performed by 
SARA with the multiple sequence T-Coffee framework. 

SARA-Coffee VM
--------------

Since setting up the SARA-Coffee dependencies can be tricky we provide a self-contained 
Vagrant VM, which downloads and configures all the required pieces of software for you. 
See http://www.vagrantup.com for more details about Vagrant.

It can be useful to quick get started with SARA-Coffee and replicate the configuration procedure. 

To launch the VM move to the project root folder `sara-coffee` and enter the following command:
  
    $ vagrant up 

The first time you run it, it will automatically download the virtual machine and all the packages required by SARA-Coffee. 
It may take some minutes to complete, so be patiente. 

When it boots up and the configuration steps are terminated, login into the VM instance:

    $ vagrant ssh 
    
Now you can run SARA-Coffee as shown: 

     $ cd sara_coffee_package/
	 $ ./sara_coffee.sh <input file> <output file> 


When finished, stop the VM using the command `vagrant halt` or `vagrant destroy`, depending if you
want to temporary stop the execution or delete permanently the VM with all its files. 


Dependencies 
------------

* [T-Coffee](http://tcoffee.org)
* [SARA](http://structure.biofold.org/sara/)
* [X3DNA](http://x3dna.org/)
* [Numpy](http://www.numpy.org/)
* [Biopython](http://biopython.org/)
* Perl
* Python 2.7


Links
-----
* [Using tertiary structure for the computation of highly accurate multiple RNA alignments with the SARA-Coffee package](http://www.ncbi.nlm.nih.gov/pubmed?term=23449094)
* http://www.tcoffee.org/Projects/saracoffee/

