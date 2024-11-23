import os
import subprocess
import sys

def init():
    os.chdir('../../../laravel/not_work/unimove')
    os.system('php artisan tinker')
init()