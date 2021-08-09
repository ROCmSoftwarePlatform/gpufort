{# SPDX-License-Identifier: MIT                                                 #}
{# Copyright (c) 2021 GPUFORT Advanced Micro Devices, Inc. All rights reserved. #}
// This file was generated by gpufort
{# Jinja2 template for generating interface modules      #}
{# This template works with data structures of the form :#}
{# *-[includes:str]                                      #}
{#  -[kernels:dict]-cName:str                            #}
{#                 -[kernelArgs:dict]                    #}
{#                 -[kernelCallArgNames:str]             #}
{#                 -[interfaceArgs:dict]                 #}
{#                 -[reductions:dict]                    #}
{#                 -[cBody:str]                          #}
{#                 -[fBody:str]                          #}

{% for file in includes %}
#include "{{file}}"
{% endfor %}
#include "hip/math_functions.h"
#include <cstdio>
#include <iostream>
#include <algorithm>

#include "gpufort.h"
{% if haveReductions -%}
#include "gpufort_reductions.h"
{%- endif -%}

{%- macro make_block(kernel) -%}
{% set krnlPrefix = kernel.kernelName %}
{% set ifacePrefix = kernel.interfaceName %}
{% for blockDim in kernel.block %}  const int {{krnlPrefix}}_block{{blockDim.dim}} = {{blockDim.value}};
{% endfor %}
  dim3 block({{ kernel.blockDims | join(",") }});
{%- endmacro -%}

{%- macro make_grid(kernel) -%}
{% set krnlPrefix = kernel.kernelName %}
{% set ifacePrefix = kernel.interfaceName %}
{% for sizeDim in kernel.size %}  const int {{krnlPrefix}}_N{{sizeDim.dim}} = {{sizeDim.value}};
{% endfor %}

{% if kernel.grid|length > 0 %}
{% for gridDim in kernel.grid %}  const int {{krnlPrefix}}_grid{{gridDim.dim}} = {{gridDim.value}};
  dim3 grid({% for gridDim in kernel.grid -%}{{krnlPrefix}}_grid{{gridDim.dim}}{{ "," if not loop.last }}{%- endfor %});
{% endfor %}{% else %}
{% for blockDim in kernel.block %}  const int {{krnlPrefix}}_grid{{blockDim.dim}} = divideAndRoundUp( {{krnlPrefix}}_N{{blockDim.dim}}, {{krnlPrefix}}_block{{blockDim.dim}} );
{% endfor %}
  dim3 grid({% for blockDim in kernel.block -%}{{krnlPrefix}}_grid{{blockDim.dim}}{{ "," if not loop.last }}{%- endfor %});
{% endif %}
{%- endmacro -%}

{%- macro synchronize(krnlPrefix) -%}
  #if defined(SYNCHRONIZE_ALL) || defined(SYNCHRONIZE_{{krnlPrefix}})
  HIP_CHECK(hipStreamSynchronize(stream));
  #elif defined(SYNCHRONIZE_DEVICE_ALL) || defined(SYNCHRONIZE_DEVICE_{{krnlPrefix}})
  HIP_CHECK(hipDeviceSynchronize());
  #endif
{%- endmacro -%}

{%- macro print_array(krnlPrefix,inout,print_values,print_norms,array,rank) -%}
  GPUFORT_PRINT_ARRAY{{rank}}("{{krnlPrefix}}:{{inout}}:",{{print_values}},{{print_norms}},{{array}},
    {%- for i in range(1,rank+1) -%}{{array}}_n{{i}},{%- endfor -%}
    {%- for i in range(1,rank+1) -%}{{array}}_lb{{i}}{{"," if not loop.last}}{%- endfor -%});
{%- endmacro -%}

{# REDUCTION MACROS #}

{%- macro reductions_prepare(kernel,star) -%}
{%- set krnlPrefix = kernel.kernelName -%}
{%- set ifacePrefix = kernel.interfaceName -%}
{%- if kernel.reductions|length > 0 -%}
{%- for var in kernel.reductions %} 
  {{ var.type }}* {{ var.buffer }};
  HIP_CHECK(hipMalloc((void **)&{{ var.buffer }}, __total_threads(({{star}}grid),({{star}}block)) * sizeof({{ var.type }} )));
{% endfor -%}
{%- endif -%}
{%- endmacro -%}

{%- macro reductions_finalize(kernel,star) -%}
{% if kernel.reductions|length > 0 -%}
{%- for var in kernel.reductions -%} 
  reduce<{{ var.type }}, reduce_op_{{ var.op }}>({{ var.buffer }}, __total_threads(({{star}}grid),({{star}}block)), {{ var.name }});
  HIP_CHECK(hipFree({{ var.buffer }}));
{% endfor -%}
{%- endif -%}
{%- endmacro %}

{% for kernel in kernels %}
{% set krnlPrefix = kernel.kernelName %}
{% set ifacePrefix = kernel.interfaceName %}

// BEGIN {{krnlPrefix}}
  /* Fortran original: 
{{kernel.fBody | indent(2, True)}}
  */
{{kernel.interfaceComment | indent(2, True)}}

{{kernel.modifier}} {{kernel.returnType}} {{kernel.launchBounds}} {{krnlPrefix}}({{kernel.kernelArgs | join(",")}}) {
{% for def in kernel.macros %}{{def.expr}}
{% endfor %}
{% for var in kernel.kernelLocalVars %}{{var | indent(2, True)}};
{% endfor %}

{{kernel.cBody | indent(2, True)}}
}

{% if kernel.generateLauncher -%}
extern "C" void {{ifacePrefix}}(dim3* grid, dim3* block, const int sharedMem, hipStream_t stream,{{kernel.interfaceArgs | join(",")}}) {
{{ reductions_prepare(kernel,"*") }}
{% if kernel.generateDebugCode %}
  #if defined(GPUFORT_PRINT_KERNEL_ARGS_ALL) || defined(GPUFORT_PRINT_KERNEL_ARGS_{{krnlPrefix}})
  std::cout << "{{krnlPrefix}}:gpu:args:";
  GPUFORT_PRINT_ARGS((*grid).x,(*grid).y,(*grid).z,(*block).x,(*block).y,(*block).z,sharedMem,stream,{{kernel.kernelCallArgNames | join(",")}});
  #endif
  #if defined(GPUFORT_PRINT_INPUT_ARRAYS_ALL) || defined(GPUFORT_PRINT_INPUT_ARRAYS_{{krnlPrefix}})
  {% for array in kernel.inputArrays %}
  {{ print_array(krnlPrefix+":gpu","in","true","true",array.name,array.rank) }}
  {% endfor %}
  #elif defined(GPUFORT_PRINT_INPUT_ARRAY_NORMS_ALL) || defined(GPUFORT_PRINT_INPUT_ARRAY_NORMS_{{krnlPrefix}})
  {% for array in kernel.inputArrays %}
  {{ print_array(krnlPrefix+":gpu","in","false","true",array.name,array.rank) }}
  {% endfor %}
  #endif{% endif %}
  // launch kernel
  hipLaunchKernelGGL(({{krnlPrefix}}), *grid, *block, sharedMem, stream, {{kernel.kernelCallArgNames | join(",")}});
{{ reductions_finalize(kernel,"*") }}

{% if kernel.generateDebugCode %}
  {{ synchronize(krnlPrefix) }}
  #if defined(GPUFORT_PRINT_OUTPUT_ARRAYS_ALL) || defined(GPUFORT_PRINT_OUTPUT_ARRAYS_{{krnlPrefix}})
  {% for array in kernel.outputArrays %}
  {{ print_array(krnlPrefix+":gpu","out","true","true",array.name,array.rank) }}
  {% endfor %}
  #elif defined(GPUFORT_PRINT_OUTPUT_ARRAY_NORMS_ALL) || defined(GPUFORT_PRINT_OUTPUT_ARRAY_NORMS_{{krnlPrefix}})
  {% for array in kernel.outputArrays %}
  {{ print_array(krnlPrefix+":gpu","out","false","true",array.name,array.rank) }}
  {% endfor %}
  #endif
{% endif %}
}
{% if kernel.isLoopKernel %}
extern "C" void {{ifacePrefix}}_auto(const int sharedMem, hipStream_t stream,{{kernel.interfaceArgs | join(",")}}) {
{{ make_block(kernel) }}
{{ make_grid(kernel) }}   
{{ reductions_prepare(kernel,"") }}
{% if kernel.generateDebugCode %}
  #if defined(GPUFORT_PRINT_KERNEL_ARGS_ALL) || defined(GPUFORT_PRINT_KERNEL_ARGS_{{krnlPrefix}})
  std::cout << "{{krnlPrefix}}:gpu:args:";
  GPUFORT_PRINT_ARGS(grid.x,grid.y,grid.z,block.x,block.y,block.z,sharedMem,stream,{{kernel.kernelCallArgNames | join(",")}});
  #endif
  #if defined(GPUFORT_PRINT_INPUT_ARRAYS_ALL) || defined(GPUFORT_PRINT_INPUT_ARRAYS_{{krnlPrefix}})
  {% for array in kernel.inputArrays %}
  {{ print_array(krnlPrefix+":gpu","in","true","true",array.name,array.rank) }}
  {% endfor %}
  #elif defined(GPUFORT_PRINT_INPUT_ARRAY_NORMS_ALL) || defined(GPUFORT_PRINT_INPUT_ARRAY_NORMS_{{krnlPrefix}})
  {% for array in kernel.inputArrays %}
  {{ print_array(krnlPrefix+":gpu","in","false","true",array.name,array.rank) }}
  {% endfor %}
  #endif
{% endif %}
  // launch kernel
  hipLaunchKernelGGL(({{krnlPrefix}}), grid, block, sharedMem, stream, {{kernel.kernelCallArgNames | join(",")}});
{{ reductions_finalize(kernel,"") }}

{% if kernel.generateDebugCode %}
  {{ synchronize(krnlPrefix) }}
  #if defined(GPUFORT_PRINT_OUTPUT_ARRAYS_ALL) || defined(GPUFORT_PRINT_OUTPUT_ARRAYS_{{krnlPrefix}})
  {% for array in kernel.outputArrays %}
  {{ print_array(krnlPrefix+":gpu","out","true","true",array.name,array.rank) }}
  {% endfor %}
  #elif defined(GPUFORT_PRINT_OUTPUT_ARRAY_NORMS_ALL) || defined(GPUFORT_PRINT_OUTPUT_ARRAY_NORMS_{{krnlPrefix}})
  {% for array in kernel.outputArrays %}
  {{ print_array(krnlPrefix+":gpu","out","false","true",array.name,array.rank) }}
  {% endfor %}
  #endif
{% endif %}
}
{% endif %}
{% if kernel.generateCPULauncher -%}
extern "C" void {{ifacePrefix}}_cpu1(const int sharedMem, hipStream_t stream,{{kernel.interfaceArgs | join(",")}});

extern "C" void {{ifacePrefix}}_cpu(const int sharedMem, hipStream_t stream,{{kernel.interfaceArgs | join(",")}}) {
{% if kernel.generateDebugCode %}
  #if defined(GPUFORT_PRINT_KERNEL_ARGS_ALL) || defined(GPUFORT_PRINT_KERNEL_ARGS_{{krnlPrefix}})
  std::cout << "{{krnlPrefix}}:cpu:args:";
  GPUFORT_PRINT_ARGS(sharedMem,stream,{{kernel.cpuKernelCallArgNames | join(",")}});
  #endif
  #if defined(GPUFORT_PRINT_INPUT_ARRAYS_ALL) || defined(GPUFORT_PRINT_INPUT_ARRAYS_{{krnlPrefix}})
  {% for array in kernel.inputArrays %}
  {{ print_array(krnlPrefix+":cpu","in","true","true",array.name,array.rank) }}
  {% endfor %}
  #elif defined(GPUFORT_PRINT_INPUT_ARRAY_NORMS_ALL) || defined(GPUFORT_PRINT_INPUT_ARRAY_NORMS_{{krnlPrefix}})
  {% for array in kernel.inputArrays %}
  {{ print_array(krnlPrefix+":cpu","in","false","true",array.name,array.rank) }}
  {% endfor %}
  #endif
{% endif %}
  // launch kernel
  {{ifacePrefix}}_cpu1(sharedMem, stream, {{kernel.cpuKernelCallArgNames | join(",")}});

{% if kernel.generateDebugCode %}
  #if defined(GPUFORT_PRINT_OUTPUT_ARRAYS_ALL) || defined(GPUFORT_PRINT_OUTPUT_ARRAYS_{{krnlPrefix}})
  {% for array in kernel.outputArrays %}
  {{ print_array(krnlPrefix+":cpu","out","true","true",array.name,array.rank) }}
  {% endfor %}
  #elif defined(GPUFORT_PRINT_OUTPUT_ARRAY_NORMS_ALL) || defined(GPUFORT_PRINT_OUTPUT_ARRAY_NORMS_{{krnlPrefix}})
  {% for array in kernel.outputArrays %}
  {{ print_array(krnlPrefix+":cpu","out","false","true",array.name,array.rank) }}
  {% endfor %}
  #endif
{% endif %}
}{% endif %}
{% endif %}
// END {{krnlPrefix}}

{% endfor %}{# kernels #}
