/*** Autogenerated by WIDL from structuredquerycondition.idl - Do not edit ***/

#include <rpc.h>
#include <rpcndr.h>

#if !defined(COM_NO_WINDOWS_H) && !defined(__WINESRC__)
#include <windows.h>
#include <ole2.h>
#endif

#ifndef __WIDL_STRUCTUREDQUERYCONDITION_H
#define __WIDL_STRUCTUREDQUERYCONDITION_H

/* Forward declarations */

/* Headers for imported files */

#include <oaidl.h>
#include <ocidl.h>
#include <objidl.h>
#include <propidl.h>

#ifdef __cplusplus
extern "C" {
#endif

typedef enum tagCONDITION_TYPE {
    CT_AND_CONDITION = 0,
    CT_OR_CONDITION = 1,
    CT_NOT_CONDITION = 2,
    CT_LEAF_CONDITION = 3
} CONDITION_TYPE;
typedef enum tagCONDITION_OPERATION {
    COP_IMPLICIT = 0,
    COP_EQUAL = 1,
    COP_NOTEQUAL = 2,
    COP_LESSTHAN = 3,
    COP_GREATERTHAN = 4,
    COP_LESSTHANOREQUAL = 5,
    COP_GREATERTHANOREQUAL = 6,
    COP_VALUE_STARTSWITH = 7,
    COP_VALUE_ENDSWITH = 8,
    COP_VALUE_CONTAINS = 9,
    COP_VALUE_NOTCONTAINS = 10,
    COP_DOSWILDCARDS = 11,
    COP_WORD_EQUAL = 12,
    COP_WORD_STARTSWITH = 13,
    COP_APPLICATION_SPECIFIC = 14
} CONDITION_OPERATION;
/* Begin additional prototypes for all interfaces */


/* End additional prototypes */

#ifdef __cplusplus
}
#endif

#endif /* __WIDL_STRUCTUREDQUERYCONDITION_H */
