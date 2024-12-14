import subprocess
import sys
import time

initial_time = int(time.time_ns())
WORKSPACE = str(sys.argv[1]).strip() if (len(sys.argv) > 1) else None
WINDOW_CONSTANT = "Window"
WORKSPACE_NAME_CONSTANT = "workspace"
CLASS_NAME_CONSTANT = "class"

SPLIT_KEY_INDEX = 0
SPLIT_VALUE_INDEX = 1
SPLIT_FILTER = ": "


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

    found_window: bool = False
    found_workspace: bool = False
    found_class: bool = False

    for line in windows.split("\n"):
        line = line.strip()
        if not line:
            found_window = False
            found_workspace = False
            found_class = False
        elif WINDOW_CONSTANT in line:
            found_window = True
        elif found_window:
            line_split = line.lower().split(SPLIT_FILTER)
            split_key = line_split[SPLIT_KEY_INDEX]
            split_value = line_split[SPLIT_VALUE_INDEX] if len(line_split) > 1 else None

            if split_key == WORKSPACE_NAME_CONSTANT and WORKSPACE in split_value:
                found_workspace = True
            elif split_key == CLASS_NAME_CONSTANT and terminal in split_value:
                found_class = True

        if found_workspace and found_class:
            return

    if not (found_workspace and found_class):
        print("Kitty no está en ejecución en el workspace 10. Iniciando Kitty...")
        subprocess.Popen(terminal, shell=False)


if __name__ == "__main__":
    main()
    finish_time = int(time.time_ns())
    time_diff = (finish_time - initial_time) / pow(10, 6)

    print("Execution time in millis: " + str(time_diff))
