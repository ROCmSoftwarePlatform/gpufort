# SPDX-License-Identifier: MIT
# Copyright (c) 2020-2022 Advanced Micro Devices, Inc. All rights reserved.
import textwrap

from gpufort import indexer

from .. import analysis
from .. import tree

def render_private_vars_decl_list(ttvalues,scope):
    decl_list_snippet = ""
    for private_var in ttvalues:
        var_expr = tree.traversals.make_fstr(private_var)
        var_tag = indexer.scope.create_index_search_tag(var_expr) 
        if "%" in var_tag:
            # todo: get rid of this limitation,  if necessary
            raise error.LimitationError("private var must not be derived type member")
        tavar = analysis.create_analysis_var(scope,var_expr) 
        c_prefix = "__shared__ " if "shared" in tavar["attributes"] else ""
        c_type = tavar["kind"] if tavar["f_type"]=="type" else tavar["c_type"]
        if tavar["rank"] == 0:
            decl_list_snippet += "{c_prefix}{c_type} {c_name};\n".format(
              c_prefix=c_prefix,
              c_type=c_type,
              c_name = tavar["c_name"]
            )
        else:
            decl_list_snippet += "{c_prefix}{c_type} _{c_name}[{total_size}];\n".format(
              c_prefix=c_prefix,
              c_type=c_type,
              total_size = "*".join(tavar["size"])
            )
            decl_list_snippet += """\
{c_name}.wrap(nullptr,&_{c_name}[0],
  {{tavar["size"] | join(",")}},
  {{tavar["lbounds"] | join(",")}});""".format(
              c_name = tavar
            )
            # array_descr is passed as argument
    return decl_list_snippet