changequote`'divert(`-1')
changequote(«,»)


# Copyright 2012,2013 Docstream A/S.


# This file is part of 'auto-ent'.

# 'auto-ent' is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# 'auto-ent' is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with 'auto-ent'.  If not, see <http://www.gnu.org/licenses/>.


define(«HAS_NONE»,)
define(«NAME», $1)

# NONE of below must be used in DSL-schema directly
define(«DOWN1ST»,«downcase(substr(«$1»,0,1))«»substr(«$1»,1)»)
define(«TAB», «    »)
define(«INDENT», «patsubst(«$1», «^», TAB())»)
define(«LTRIM», «patsubst(«$*», «^[ \t]*», «»)»)
define(«RTRIM», «patsubst(«$*», «[ \t]*$», «»)»)
define(«RM_TRAILING», «patsubst(«$1», «$2$», «»)»)
define(«UNCOM», «patsubst(«$1», «^[ \t]*#.*$», «»«dnl»)»)
define(«PURE», «LTRIM(«UNCOM($1)»)»)
define(«TRIM_LF», «patsubst(«$*», «
», «»)»)
define(«CAMEL», 
«PURE(translit(capitalize(translit(«$1», «_», « »)), « », «»))»)


# LOOPers

define(«MAP_PURE», 
«ifelse(«$#», «0», , «$#», «1», «PURE(«$1»)»,dnl
«ifelse( PURE(«$1»), «», $0(shift($@)), PURE(«$1»)
$0(shift($@)))»)»)

define(«MAP_PURE_COMMA», 
«ifelse(«$#», «0», , «$#», «1», «PURE(«$1»)»,dnl
«ifelse( PURE(«$1»), «», $0(shift($@)), «PURE(«$1»)«, »$0(shift($@))»)»)»)

define(«MAP_LTRIM», 
«ifelse(«$#», «0», , «$#», «1», «LTRIM(«$1»)»,
«LTRIM(«$1»)  
$0(shift($@))»)»)


#
# Part taken from GNU m4 Manual
#
# upcase(text)
# downcase(text)
# capitalize(text)
#   change case of text, improved version
define(«upcase», «translit(«$*», «a-z», «A-Z»)»)
define(«downcase», «translit(«$*», «A-Z», «a-z»)»)
define(«_arg1», «$1»)
define(«_to_alt», «changequote(«<<[», «]>>»)»)
define(«_from_alt», «changequote(<<[«]>>, <<[»]>>)»)
define(«_upcase_alt», «translit(<<[$*]>>, <<[a-z]>>, <<[A-Z]>>)»)
define(«_downcase_alt», «translit(<<[$*]>>, <<[A-Z]>>, <<[a-z]>>)»)
define(«_capitalize_alt»,
  «regexp(<<[$1]>>, <<[^\(\w\)\(\w*\)]>>,
    <<[_upcase_alt(<<[<<[\1]>>]>>)_downcase_alt(<<[<<[\2]>>]>>)]>>)»)
define(«capitalize»,
  «_arg1(_to_alt()patsubst(<<[<<[$*]>>]>>, <<[\w+]>>,
    _from_alt()«]>>_$0_alt(<<[\&]>>)<<[»_to_alt())_from_alt())»)
divert«»dnl
