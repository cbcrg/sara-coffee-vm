SARA-COFFEE
===========

SARA-Coffee is a structure based multiple RNA aligner. 

This is a new algorithm that joins the pairwise RNA structure alignments performed by 
SARA with the multiple sequence T-Coffee framework. 

SARA-Coffee VM
--------------

Since setting up the SARA-Coffee dependencies can be tricky we provide a self-contained 
Vagrant VM, which downloads and configures all the required pieces of software for you. 

Install or update virtual box from https://www.virtualbox.org/wiki/Downloads

Install or update vagrant from: http://www.vagrantup.com

Clone the sara-coffee virtual machine (this project) in a convenient location

    $ git clone https://github.com/cbcrg/sara-coffee-vm.git

Enter the `sara-coffee-vm` folder and launch vagrant:
    $ cd sara-coffee-vm/
    $ vagrant up  

The first time you run it, it will automatically download the virtual machine and all the packages required by SARA-Coffee. It may take some minutes to complete, so be patient. 

When it boots up and the configuration steps are terminated, login into the VM instance:

    $ vagrant ssh 
    
You are now in the Sara-Coffee virtual machine. Now you can run SARA-Coffee as shown: 

    $ cd sara_coffee_package/
    $ ./sara_coffee.sh <input file> <output file> 

The folder '/vagrant/' is shared between the Sara-Coffee virtual and your local machine. On your local machine, this fiolder is the one in which you started vagrant (i.e. sara-coffee-vm)

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
* http://tcoffee.crg.cat/apps/tcoffee/do:saracoffee
* http://www.tcoffee.org/Projects/saracoffee/

