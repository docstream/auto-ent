#; Demo file, using the auto-ent «DSL»
#; m4 based syntax
#;
#; Using the symbols: '«' and '»' for quoting.
#; ( AltGr+z , AltGr+x )
#;

# Main ent.
ENTITY(

    # Name of the 'thing'
    # The 'thing' is an 'entity' aka 'table' 
    # aka 'bean' aka 'struct' etc
     NAME(«root»), 
                                 
    # Key[s]
     PRIMARY_KEYS(«id ASC»),
       
    # Allowed operation[s]
    #;   if generated code depends on our <ORM> 
     OPS(GET, PUT),
               
    # Chidren, one->many relations 
    #;   using 's' in name [as prefix] to connect
     HAS_MANY(«names», «meta_values»), 
       
    # Members section :
    #;  param1 = name 
    #;  param2 = data-type ;
    #;     < string | int | decimal | bool >
    #;  param3 = xml-node-type ; < elem | attrib >
    #;  param4 = < never_nil | allows_nil >
    #;  param5 = default value. 
    #;     bool must be ; < TRUE | FALSE >
    #;     string must be wrapped in ; STR(«text»)

    FLD(«id», string, attrib, never_nil),
    FLD(«sort_index», int, attrib, never_nil, 0),
    FLD(«src», string, elem, allows_nil),
    FLD(«enabled», bool, elem, never_nil, TRUE),
    FLD(«some_flag», bool, elem, allows_nil)
)

# name is connected to root
ENTITY(

    NAME(«name»),
                                 
    PRIMARY_KEYS(«root_id ASC», «lang ASC»),
       
    OPS(GET, PUT, DELETE),

    #; No relations further 'down' on this one
    HAS_NONE(),

    # Members section :
   
    # FK, not public since 3rd param == NEITHER
    FLD(«root_id», string, NEITHER, never_nil),
    FLD(«lang», string, attrib, never_nil),
    FLD(«name», string, elem, never_nil),
    FLD(«tooltip», string, elem, allows_nil)
)

# Another .. not connected
ENTITY(

    NAME(«lang_code»),

    PRIMARY_KEYS(«code ASC»),

    OPS(GET, PUT, DELETE),

    HAS_NONE(),

    # Members section :
    
    # no/sv/da/en/es etc.
    FLD(«code», string, attrib, never_nil),
    FLD(«descr», string, elem, never_nil, STR(«description»))
)

# Last one, connected to root
ENTITY(
        
    NAME(«meta_value»),
    
    PRIMARY_KEYS(«root_id ASC»,«key ASC»),

    OPS(GET, PUT, DELETE),

    HAS_NONE(),

    # Members section :

    # FK, not public
    FLD(«root_id», string, NEITHER, never_nil),
    FLD(«key», string, attrib, never_nil),
    FLD(«value», string, elem, allows_nil)
) 

