Another (m4) DSL to rule them all
=================================

_Work in progress_
-------------------

CLI Tool that generates java/go entity classes/structs (stdout).  
Will also (soon) generate SQL schemas, from same DSL file.  
XML serializable features are annotated into go+java output.  
Optional ORM-stuff for the go output.

Depends on gnu{make,m4,sed}

Supports [for now] :

* Go (orm|xml)
* Java (JAXB)

comming :

* SQL 
* C ?

Manual
=======
./autogen-entitys help
