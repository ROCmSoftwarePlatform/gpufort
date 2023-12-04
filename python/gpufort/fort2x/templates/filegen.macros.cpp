{#- SPDX-License-Identifier: MIT                                        -#}
{#- Copyright (c) 2020-2022 Advanced Micro Devices, Inc. All rights reserved.-#}
{%- macro render_c_file(guard,
                        snippets=[],
                        includes=[],
                        prolog="// This file was autogenerated by GPUFORT",
                        includes_prolog="",
                        includes_epilog="") -%}
{% if prolog|length %}
{{prolog}}
{% endif %}
#ifndef {{guard}}
#define {{guard}}
{% if includes_prolog|length %}
{{includes_prolog}}
{% endif %}
{% for include in includes %}
#include "{{include}}"
{% endfor %}
{% if includes_epilog|length %}
{{includes_epilog}}
{% endif %}
{% if snippets|length %}

{% for snippet in snippets %}
{{snippet}}{{"\n" if not loop.last}}
{% endfor %}{# snippets #}
{% endif %}
#endif // {{guard}}
{%- endmacro -%}