# pylib-template

**A modern [Copier](https://copier.readthedocs.io/) template designed to quickly bootstrap Python library projects with best practices, tooling, and automation built-in.**

## Features

The template provides:

- **Python Version Support**: Choose from Python 3.10, 3.11, 3.12, 3.13, or 3.14
- **Input Validation**: Ensures project names and slugs follow Python naming conventions
- **Pre-configured Automation**: Post-generation tasks including:
  - Git initialization with `main` branch
  - Dependency management via [`uv`](https://docs.astral.sh/uv/)
  - Code formatting with [`ruff`](https://docs.astral.sh/ruff/)
  - Type checking with [`pyrefly`](https://pyrefly.org/en/docs/)
  - Pre-commit hooks via [`prek`](https://prek.j178.dev/)
  - Rather strict lint and typing checks

## Configuration Options

When generating a new project, you'll be prompted for:

### `project_name` (required)
- **Format**: Lowercase letters, digits, and underscores
- **Constraints**: Must start and end with a letter or digit
- **Example**: `my_library`, `awesome_tool`

### `project_slug` (auto-generated, customizable)
- **Format**: Lowercase letters, digits, and hyphens
- **Default**: Project name with underscores replaced by hyphens
- **Constraints**: Must start and end with a letter or digit
- **Example**: `my-library`, `awesome-tool`

### `python_version`
- **Choices**: 3.10, 3.11, 3.12 (default), 3.13, 3.14
- **Default**: Python 3.12

## Usage

⚠️ You need to specify `--trust` because of the automation tasks. These are defined on the [`copier.yml`](copier.yml) file

To create a new project from this template:

```bash
copier copy --trust https://github.com/cepedus/pylib-template /path/to/new/project
```
