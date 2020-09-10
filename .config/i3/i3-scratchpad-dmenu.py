#!/usr/bin/env python3

import i3ipc
import sys
import subprocess

# configure parameters to send to dmenu
dmenu_args = ['-i']

i3 = i3ipc.Connection()
tree = i3.get_tree()
scratch = tree.scratchpad()
focused = tree.find_focused()
cur_con_is_sp = False

# does not handle duplicate window names for now
sp_windows = {node.find_named('.*')[0].name: node.nodes[0]
              for node in scratch.floating_nodes}

if len(sp_windows) == 0:  # happens also when the only scratchpad is focused
    sys.exit(0)

# if current window is a scratchpad, then hide it
p = focused
while p.type != 'workspace':
    if p.floating and (p.scratchpad_state != 'none'):
        cur_con_is_sp = True
        break
    p = p.parent

if cur_con_is_sp:
    i3.command('scratchpad show')

# send all window names to dmenu and get selection
dm_proc = subprocess.Popen(["dmenu"] + dmenu_args, 
                           stdin=subprocess.PIPE,
                           stdout=subprocess.PIPE,
                           universal_newlines=True)
sel_focus = dm_proc.communicate('\n'.join(sp_windows.keys()))

if dm_proc.returncode != 0:  # possibly user pressed Esc, do nothing
    sys.exit(1)

focus_win_name = sel_focus[0].strip()

# focus it
try:
    sp_windows[focus_win_name].command('focus')
except KeyError as e:
    sys.exit(2)
