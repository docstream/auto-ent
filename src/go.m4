changequote`'divert(`-1')
changequote(«,»)

# go version

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



define(«GO_LIST_FLD»,«dnl
define(«_fldn», «$1»)dnl
define(«_structn», «RM_TRAILING(RTRIM($1), «s»)»)dnl 
_fldn []_structn `xml:"_fldn()>_structn()"`»)



# Redirecting Loop :
define(«HAS_MANY», «ifelse(«$#», «0», , «$#», «1», 
«GO_LIST_FLD($1)»,
«GO_LIST_FLD($1)
HAS_MANY(shift($@))»)»)


# ----------------------------
# ENTITY macro
# ----------------------------
define(«ENTITY», «dnl
dnl
dnl Helper(s)
define(«FLDS»,«shift(shift(shift(shift($@))))»)dnl
dnl
dnl
/* ---------------------------------------
 *
 *
 *       E n t i t y   ::  CAMEL($1)  
 *
 *
 * --------------------------------------- */
type CAMEL($1) struct {
dnl
dnl
dnl xml-root-elem-name as struct member
INDENT(«
XMLName xml.Name `xml:"PURE($1)"`
»)
dnl
dnl
dnl struct members , part 1
dnl
dnl NB! NASTY thing, 
dnl   has comma in output
dnl
define(«OPT_XML_PART», ifelse( $«»2, «NEITHER», `-`,
 «`xml:"$«»1««,»»$«»2"`»))dnl
define(«XML_ANNOT», `xml:"$«»1««,»»$«»2"`)dnl
dnl
define(«FLD», «dnl
define(«_name», ifelse(»$«»3«, «NEITHER»,
DOWN1ST(CAMEL(»$«»1«)),CAMEL(»$«»1«)))dnl
define(«_param_cnt»,»$«#»«)dnl
define(«_node_type», ifelse( eval(_param_cnt()« > 2»),
 «1», »$«»3«, ««elem»»))dnl
_name() »$«»2« ifelse( »$«»3«, «NEITHER», `-`,
 «XML«_»ANNOT( »»$«»1««, »_node_type()«)»)
»)dnl
INDENT(MAP_LTRIM(FLDS()))dnl
dnl
dnl
dnl relational-stuff , part 2
dnl    HAS_MANY or HAS_NONE
dnl
INDENT(LTRIM(«$4»))

INDENT(«// Injects a flag»)
INDENT(«Deletable»)

}

// connect with SQL
func (obj *CAMEL($1)) Fill(row *sql.Row) error {
    // TODO
}

func (obj *CAMEL($1)) Validate() bool {
    // TODO
}

// connect with ORM-sys
func init() {
    // TDOD
}


»)


define(«CLOSING_FUNC», «dnl

// Start up the ORM
func init() { initORM() }
»)

m4wrap(«CLOSING_FUNC»)

divert«»dnl
package PACKAGE

import "database/sql"
import . "ds3g/orm"

