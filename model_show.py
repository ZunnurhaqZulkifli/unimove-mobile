import os
import subprocess
import sys

def init():
    os.chdir('../../../laravel/not_work/unimove')
    model_name = sys.argv[1] if len(sys.argv) > 1 else ''
    if model_name:
        try:
            result = subprocess.run(['php', 'artisan', 'model:show', model_name], capture_output=True, text=True)
            print(result.stdout)
            if result.stderr:
                print(result.stderr, file=sys.stderr)
        except Exception as e:
            print(f"An error occurred: {e}", file=sys.stderr)
    else:
        print("Please provide a model name as an argument.", file=sys.stderr)

if __name__ == "__main__":
    init()