changequote`'divert(`-1')
changequote(«,»)

# java version

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


# -----------
#  DSL static
# -----------
define(«attrib», «Attribute»)
define(«elem», «Element»)
define(«string», «String»)
define(«bool», «boolean»)
define(«TRUE», «true»)
define(«FALSE», «false»)
define(«STR», «"$1"»)
define(«datetime», «Date»)

# redirecting Loop:
define(«HAS_MANY», «ifelse(«$#», «0», , «$#», «1», 
«LIST_FLD($1)»,
«LIST_FLD($1)
$0(shift($@))»)»)



# ----------------------------
# ENTITY macro
# ----------------------------
define(«ENTITY», «dnl
dnl
  @XmlRootElement(name="PURE($1)")
  @XmlType
  static public class CAMEL($1) {

dnl Helper:
define(«FLDS»,«shift(shift(shift(shift($@))))»)dnl
dnl
dnl Empty (default bean) CTOR:
INDENT(«// Ctors :»)

INDENT(public CAMEL($1)(){})

dnl
dnl A nice-to-have-CTOR (max 3 flds)
define(«FLD», « »$«»2« DOWN1ST(CAMEL(»$«»1«))»)dnl
INDENT(public CAMEL($1)(TRIM_LF(J_FIRST3_AS_PARAMS(FLDS()))){)
define(«FLD», «this.DOWN1ST(CAMEL(»$«»1«)) = DOWN1ST(CAMEL(»$«»1«));»)dnl
INDENT(J_FIRST3_AS_LINES(FLDS()))
INDENT(})

dnl
dnl
dnl Atomic privates , part 1
define(«FLD», «dnl
define(«_set_default», «ifelse( »$«»1«, «», , « = »»$«»1«)»)dnl
private »$«»2« DOWN1ST(CAMEL(»$«»1«))«»_set_default(»$«»5«);
»)dnl
INDENT(MAP_LTRIM(FLDS()))
dnl
dnl Collection(List) privates, part 2
dnl ۰ called from HAS_MANY LOOP 
define(«LIST_FLD»,«dnl
define(«_T», «List<»CAMEL(RM_TRAILING(»$«»1«, «s»))«>»)dnl 
private _T DOWN1ST(CAMEL(»$«»1«)) = new ArrayList<>();»)dnl
dnl
ifelse(PURE($4), «», , 
INDENT(«// Collections:»)
INDENT(PURE(«$4»))


)dnl
dnl
dnl Getters and setters , part 1
define(«FLD», «define(«_param_cnt»,»$«#»«)dnl 
ifelse( eval(_param_cnt« > 2»), «1», 
ifelse( »$«»3«, «NEITHER», @XmlTransient
, J_XML_ANNOT(»$«»3«,»$«»1«)),
J_XML_ANNOT(elem(), »$«»1«))dnl
define(«_getter_prefix», ifelse(»$«»2«, bool(), «is», «get»))dnl
public »$«»2« _getter_prefix«»CAMEL(»$«»1«)() {
return this.DOWN1ST(CAMEL(»$«»1«));
}
public void set«»CAMEL(»$«»1«)(»$«»2« value) {
««this.»»DOWN1ST(CAMEL(»$«»1«)) = value;
}
»)dnl
INDENT(MAP_PURE(FLDS()))
dnl
dnl
dnl
dnl Collection(List) getter and setters , part 2
dnl ۰ called from HAS_MANY LOOP
define(«LIST_FLD»,«dnl
define(«_ent_name», RM_TRAILING(»$«»1«, «s»))dnl
@XmlElementWrapper(name="»$«»1«") 
@XmlElement(name="»_ent_name()«")
public List<CAMEL(»_ent_name()«)> get«»CAMEL(»$«»1«)() {
return this.DOWN1ST(CAMEL(»$«»1«));
}
public void set«»CAMEL(»$«»1«)(List<CAMEL(»_ent_name()«)> value) {
««this.»»DOWN1ST(CAMEL(»$«»1«)) = value;
}
»)dnl
ifelse( PURE($4), «», ,
INDENT(PURE(«$4»))
)dnl
dnl
dnl
dnl toString()
INDENT(«@Override
public String toString() {
StringBuilder sb = new StringBuilder();
»)
define(«FLD», «len(»$«»1«)»)
INDENT(«int w = Collections.max(Arrays.asList(RTRIM(TRIM_LF(MAP_PURE_COMMA(FLDS())))));
String fmt = "%-" + w + "s: %s\n";
»)
define(«FLD», 
«sb.append( format ( fmt, "DOWN1ST(CAMEL(»$«»1«))", Beans.toStringWrap(DOWN1ST(CAMEL(»$«»1«))) ) );»)dnl
INDENT(MAP_PURE(FLDS()))
define(«LIST_FLD»,«dnl
define(«_ent_name», RM_TRAILING(»$«»1«, «s»))dnl
sb.append("DOWN1ST(CAMEL(»$«»1«)) :\n");
for( CAMEL(_ent_name()) item : DOWN1ST(CAMEL(»$«»1«)) ) {
  sb.append( "  ┬\n" );  
  List<String> lines = Arrays.asList(item.toString().split("\n"));
  for (String line : lines) { sb.append("  ├ " + line + "\n"); }
  sb.append( "  °\n" ); 
}»)dnl
ifelse( PURE($4), «», ,
INDENT(PURE(«$4»))
)dnl
INDENT(«return sb.toString();
}»)
dnl
undefine(«FLD»)dnl reset
undefine(«LIST_FLD»)dnl reset
dnl
dnl

  } // End of class CAMEL($1) »)




# -----------
# Helpers:
# -----------
define(«J_XML_ANNOT», «@Xml$1(name="$2")
»)



# --------------------------
# Silly LOOPs   ^o^  łΏł
# --------------------------


define(«J_FIRST3_AS_LINES», 
«ifelse(«$#», «0», «errprint(«No FLD(s) on this ENTITY!»)m4exit(«1»)»,
«$#», «1», «TRIM_LF(PURE(«$1»))»,dnl
«$#», «2», «PURE(«$1»)
TRIM_LF(PURE(«$2»))»,dnl
«PURE(«$1»)
PURE(«$2»)
TRIM_LF(PURE(«$3»))»)»)

define(«J_FIRST3_AS_PARAMS», 
«ifelse(«$#», «0», «errprint(«No FLD(s) on this ENTITY!»)m4exit(«1»)»,
«$#», «1», «PURE(«$1»)»,dnl
«$#», «2», «PURE(«$1»), PURE(«$2»)»,dnl
«PURE(«$1»), PURE(«$2»), PURE(«$3»)»)»)

# --------------------------
# The wrapper aka TOP_CLASS 
# ———————————————————————————

define(«CLASS_CLOSER», «

INDENT(«/** Helper wrapping func */
private static String toStringWrap( Object o ) {
    if (o instanceof String) { return "\"" + o + "\""; }
    else { return String.valueOf(o); } 
}»)

} // End of class TOP_CLASS
»)
m4wrap(«CLASS_CLOSER»)

divert«»dnl
package PACKAGE;

import javax.xml.bind.annotation.*;
import java.util.List;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Arrays;
import java.util.Date;
import static java.lang.String.format;

/* AUTO-GENERATED !! DO NOT TOUCH */

public final class TOP_CLASS {

  // Each entity as a static class below:
 
