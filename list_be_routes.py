import os
import subprocess
import sys

def init():
    os.chdir('../../../laravel/not_work/unimove')
    os.system('php artisan route:list --path=api')
    current_dir = os.getcwd()
    
    print("Current directory:", current_dir)

init()