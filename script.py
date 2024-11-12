import os

def generate_folder_structure(start_path, indent=""):
    items = os.listdir(start_path)
    items.sort()
    result = ""
    for i, item in enumerate(items):
        path = os.path.join(start_path, item)
        is_last = i == len(items) - 1
        connector = "└── " if is_last else "├── "
        if os.path.isdir(path):
            result += f"{indent}{connector}{item}/\n"
            new_indent = indent + ("    " if is_last else "│   ")
            result += generate_folder_structure(path, new_indent)
        else:
            result += f"{indent}{connector}{item}\n"
    return result

# Cambia 'lib' por la ruta de la carpeta que deseas inspeccionar.
start_path = "lib"
folder_structure = generate_folder_structure(start_path)
print(f"{start_path}/")
print(folder_structure)
