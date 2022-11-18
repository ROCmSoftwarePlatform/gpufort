# SPDX-License-Identifier: MIT
# Copyright (c) 2020-2022 Advanced Micro Devices, Inc. All rights reserved.
import enum
import copy

from gpufort import util    

statement_classifier = util.parsing.StatementClassifier()

class ValueType(enum.Enum):
    UNKNOWN = 0
    PROCEDURE = 1
    VARIABLE = 2
    INTRINSIC = 3

DEFAULT_IMPLICIT_SPEC =\
  statement_classifier.parse_implicit_statement(
    "IMPLICIT integer (i-n), real (a-h,o-z)")

EMPTY_TYPE = {
   "name": None,
   "kind": None,
   "attributes": [],
   "accessibility": None,
   "public": [], 
   "private": [], 
   "params": [],
   "variables": [],
   # meta information
   "file": None,
   "lineno": None,
   # dummy entries that never carry data,
   # they make the type look like a module to certain routines
   # todo: should use dict.get(key,default) instead.
   "types": [],
}

EMPTY_PROCEDURE = {
  "name": None,
  "kind": None,
  "result_name": None,
  "attributes": [],
  "dummy_args": [],
  "variables": [],
  "procedures": [],
  "used_modules": [],
  # meta information
  "file" : None,
  "lineno" : -1,
}

EMPTY_SCOPE = {"tag": "", "types": [], "variables": [], "procedures": [], "index": [], "implicit": None}
SCOPE_ENTRY_TYPES = ["types", "variables", "procedures"]

EMPTY_VAR = {
  "name"   : None,
  "f_type" : None,
  "len"    : None,
  "kind"   : None,
  "params" : [],
  # todo: bytes per element can be computed on the fly
  "bytes_per_element" : None,
  "c_type" : None,
  "attributes" : [],
  # ACC/OMP
  "declare_on_target" : None,
  # arrays
  "bounds" : [],
  "rank"   : -1,
  # parse rhs if necessary
  "rhs" : None,
  # meta information
  "module": None, # todo: Compare vs parent_tag in scope variables
  "file" : None,
  "lineno" : -1,
}

def new_scope():
    return copy.deepcopy(EMPTY_SCOPE)

def copy_scope(existing_scope,index=None,tag=None,implicit=None):
    """
    :note: All scope entry lists but not their members (dict references)
           are copied as it is assumed that the copied scope's lists
           are modified later on.
           Scope entry list members can be numerous and large,
           so a simple deep copy can quickly become too time consuming.
    :note: Implicit rule is local to a scope and hence set to None here.
    :note: 
    """
    copied_scope = new_scope()
    for scope_entry in SCOPE_ENTRY_TYPES:
        copied_scope[scope_entry] += existing_scope[scope_entry] 
    copied_scope["tag" ] = (
      existing_scope["tag"] if tag == None
      else tag
    )
    copied_scope["index" ] = (
      existing_scope["index"] if index == None 
      else index
    )
    copied_scope["implicit" ] = (
      existing_scope["implicit"] if implicit == None
      else implicit
    )
    return copied_scope

def create_index_var(f_type,
                     f_len,
                     kind,
                     params,
                     name,
                     attributes=[],
                     bounds=[],
                     rhs=None,
                     module=None,
                     filepath="<unknown>",
                     lineno=-1):
    ivar = copy.deepcopy(EMPTY_VAR)
    # basic
    ivar["name"]        = name
    ivar["f_type"]      = f_type
    ivar["kind"]        = kind
    ivar["len"]         = f_len
    ivar["params"]      = params
    # todo: bytes per element can be computed on the fly
    ivar["attributes"] += attributes
    # arrays
    ivar["bounds"] += bounds
    ivar["rank"]   = len(bounds)
    # handle parameters
    #ivar["value"] = None # todo: parse rhs if necessary
    ivar["rhs"] = rhs
    # meta information
    ivar["file"] = filepath
    ivar["lineno"] = lineno
    return ivar

def render_datatype(ivar):
    datatype = ivar["f_type"]
    args = []
    if datatype == "character":
        if ivar["len"] != None:
            args.append(ivar["len"])
    if datatype != "type" and ivar["kind"] != None:
        args.append(ivar["kind"])
    elif datatype == "type":
        arg1 = ivar["kind"]
        if len(ivar["params"]):
            arg1.append("(")
            arg1.append(",".join(ivar["params"]))
            arg1.append(")")
        args.append("".join(arg1))
    if len(args):
        return datatype + "(" + ",".join(args) + ")"
    else:
        return datatype
    
def render_declaration(ivar):
    result = [render_datatype(ivar)]
    if len(ivar["attributes"]):
        result += [", ",", ".join(ivar["attributes"])]
    result += [" :: ",ivar["name"]]
    if len(ivar["bounds"]):
        result += ["(",", ".join(ivar["bounds"]),")"]
    if ivar["rhs"] != None:
        if "pointer" in ivar["attributes"]:
            result += [" => ",ivar["rhs"]]
        else:
            result += [" = ",ivar["rhs"]]
    return "".join(result)