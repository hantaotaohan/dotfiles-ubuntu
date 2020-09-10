#!/usr/bin/env python3

import i3ipc
import subprocess
import re

i3 = i3ipc.Connection()

def get_scratchpad_windows():
    scratchpad_containers = i3.get_tree().scratchpad().descendents()
    return filter(lambda c: c.type == 'con' and c.name, scratchpad_containers)

def dmenu_choose(options):
    """ Show a dmenu to choose a string item from a list of *options*. """
    dmenu_process = subprocess.Popen(["dmenu", "-l", "10"], stdin=subprocess.PIPE, stdout=subprocess.PIPE)
    stdoutdata, _ = dmenu_process.communicate("\n".join(options).encode())
    return stdoutdata.decode('utf-8')

def main():
    scratchpad_windows = get_scratchpad_windows()
    window_titles = [w.name for w in scratchpad_windows]
    if window_titles:
        window_to_restore = re.escape(dmenu_choose(window_titles).strip())
        i3.command('[title="{}"] scratchpad show'.format(window_to_restore))

if __name__ == '__main__':
    main()
