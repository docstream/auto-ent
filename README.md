Another (m4) DSL to rule them all
=================================

_Work in progress_
-------------------

DDD CLI Tool that generates java/go entity classes/structs to stdout.  
Will also generate SQL schemas, from same DSL file.  
XML serializable features are annotated into go+java output.  
Optional ORM-stuff for the go output.

Depends on gnu{make,m4,sed}

Supports [for now] :

* Go (orm|xml)
* Java (JAXB)
* SQL (soon)

Manual
=======
./autogen-entitys help
