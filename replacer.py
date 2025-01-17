import os
from jinja2 import Template

prefix = "GUN_"
# Path to the Jinja2 template
template_path = "gunicorn.conf.tpl"
output_path = "gunicorn.conf.py"

# Read the Jinja2 template
with open(template_path, "r") as file:
    template_content = file.read()

# Create a Jinja2 template object
template = Template(template_content)

# Render the template with environment variables with fallback default value
print(f"Get value from env variables with {prefix} prefix")
env_vars = {key: value for key, value in os.environ.items() if key.startswith(prefix)}

# Render the template
template = Template(template_content)
rendered_content = template.render(env_vars)

print(rendered_content)
# Write the rendered content to a new file
with open(output_path, "w") as file:
    file.write(rendered_content)

print(f"Rendered configuration written to {output_path}")