import subprocess
import sys

WORKSPACE = str(sys.argv[1]).strip() if (len(sys.argv) > 1) else None

def get_process_stdout(cmd: []):
    try:
        result = subprocess.run(cmd, capture_output=True, text=True)
        return result.stdout
    except Exception as e:
        print(f"Error ejecutando ${cmd}: {e}")
        return []

def get_windows():
    try:
        return get_process_stdout(["hyprctl", "clients"])
    except Exception as e:
        print(f"Error ejecutando hyprctl: {e}")
        return []

def get_terminal_command():
    try:
        user_home = "/home/" + get_process_stdout(["whoami"]).strip()
        terminal_script_path = user_home + "/.config/ml4w/settings/terminal.sh"

        with open(terminal_script_path) as f:
            return f.read().strip()
    except FileNotFoundError:
        print("Archivo terminal.sh no encontrado.")
        return None

def main():
    if not WORKSPACE:
        return

    windows = get_windows()
    terminal = get_terminal_command()

    if not terminal:
        return

    found_window = False
    found_workspace = False
    found_class = False

    for line in windows.split("\n"):
        if not line.strip():
            found_window = False
            found_workspace = False
            found_class = False
        elif "Window" in line:
            found_window = True
        elif found_window:
            line_split = line.strip().lower().split(": ")
            if line_split[0] == "workspace" and WORKSPACE in line_split[1]:
                found_workspace = True
            elif line_split[0] == "class" and "kitty" in line_split[1]:
                found_class = True
        
        if found_workspace and found_class:
            return


    if not (found_workspace and found_class):
        print("Kitty no está en ejecución en el workspace 10. Iniciando Kitty...")
        subprocess.Popen(terminal, shell=True)

if __name__ == "__main__":
    main()