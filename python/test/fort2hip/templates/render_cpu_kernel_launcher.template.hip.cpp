{% import "fort2hip/templates/hip_implementation.macros.hip.cpp" as hm %}
{{ hm.render_cpu_kernel_launcher(kernel) }} 