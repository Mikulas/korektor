/* -----------------------------------------------------------------------------
 * std_string.i
 *
 * Typemaps for std::string and const std::string&
 * These are mapped to a Java String and are passed around by value.
 *
 * To use non-const std::string references use the following %apply.  Note
 * that they are passed by value.
 * %apply const std::string & {std::string &};
 * ----------------------------------------------------------------------------- */

namespace std {

%naturalvar u16string;

class u16string;

// string
%typemap(jni) string "jstring"
%typemap(jtype) string "String"
%typemap(jstype) string "String"
%typemap(javadirectorin) string "$jniinput"
%typemap(javadirectorout) string "$javacall"

%typemap(in) u16
%{ if(!$input) {
     SWIG_JavaThrowException(jenv, SWIG_JavaNullPointerException, "null string");
     return $null;
    }
    const char *$1_pstr = (const char *)jenv->GetStringUTFChars($input, 0);
    if (!$1_pstr) return $null;
    $1.assign($1_pstr);
    jenv->ReleaseStringUTFChars($input, $1_pstr); %}

%typemap(directorout) u16
%{ if(!$input) {
     if (!jenv->ExceptionCheck()) {
       SWIG_JavaThrowException(jenv, SWIG_JavaNullPointerException, "null string");
     }
     return $null;
   }
   const char *$1_pstr = (const char *)jenv->GetStringUTFChars($input, 0);
   if (!$1_pstr) return $null;
   $result.assign($1_pstr);
   jenv->ReleaseStringUTFChars($input, $1_pstr); %}

%typemap(directorin,descriptor="Ljava/lang/String;") u16string
%{ $input = jenv->NewStringUTF($1.c_str());
   Swig::LocalRefGuard $1_refguard(jenv, $input); %}

%typemap(out) u16string
%{ $result = jenv->NewStringUTF($1.c_str()); %}

%typemap(javain) u16string "$javainput"

%typemap(javaout) u16string {
    return $jnicall;
  }

%typemap(typecheck) u16string = char *;

%typemap(throws) u16string
%{ SWIG_JavaThrowException(jenv, SWIG_JavaRuntimeException, $1.c_str());
   return $null; %}

// const u16string &
%typemap(jni) const u16string & "jstring"
%typemap(jtype) const u16string & "String"
%typemap(jstype) const u16string & "String"
%typemap(javadirectorin) const u16string & "$jniinput"
%typemap(javadirectorout) const u16string & "$javacall"

%typemap(in) const u16string &
%{ if(!$input) {
     SWIG_JavaThrowException(jenv, SWIG_JavaNullPointerException, "null string");
     return $null;
   }
   const char *$1_pstr = (const char *)jenv->GetStringUTFChars($input, 0);
   if (!$1_pstr) return $null;
   $*1_ltype $1_str($1_pstr);
   $1 = &$1_str;
   jenv->ReleaseStringUTFChars($input, $1_pstr); %}

%typemap(directorout,warning=SWIGWARN_TYPEMAP_THREAD_UNSAFE_MSG) const u16string &
%{ if(!$input) {
     SWIG_JavaThrowException(jenv, SWIG_JavaNullPointerException, "null u16string");
     return $null;
   }
   const char *$1_pstr = (const char *)jenv->GetStringUTFChars($input, 0);
   if (!$1_pstr) return $null;
   /* possible thread/reentrant code problem */
   static $*1_ltype $1_str;
   $1_str = $1_pstr;
   $result = &$1_str;
   jenv->ReleaseStringUTFChars($input, $1_pstr); %}

%typemap(directorin,descriptor="Ljava/lang/String;") const u16string &
%{ $input = jenv->NewStringUTF($1.c_str());
   Swig::LocalRefGuard $1_refguard(jenv, $input); %}

%typemap(out) const u16string &
%{ $result = jenv->NewStringUTF($1->c_str()); %}

%typemap(javain) const u16string & "$javainput"

%typemap(javaout) const u16string & {
    return $jnicall;
  }

%typemap(typecheck) const u16string & = char *;

%typemap(throws) const u16string &
%{ SWIG_JavaThrowException(jenv, SWIG_JavaRuntimeException, $1.c_str());
   return $null; %}

}
