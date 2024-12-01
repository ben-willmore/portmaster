#!/usr/bin/env python3

from os import remove
from os.path import realpath, dirname
from subprocess import run
import dialog

pmhacks_port_dir = dirname(dirname(realpath(__file__)))
ports_dir = dirname(pmhacks_port_dir)
flag_file = pmhacks_port_dir+'/External Controllers.hack/enabled'

d = dialog.Dialog(dialog=pmhacks_port_dir+'/whiptail/whiptail',
                  compat='whiptail')

def call(*args, **kwargs):
  res = run(*args, **kwargs, capture_output=True)
  ports = res.stderr.decode().split('\n')
  ports = [p for p in ports if p != '']
  return ports

## Main menu

menu = [
    ('Install', 'Modify startup scripts so PM Hacks can be used'),
    ('Uninstall', 'Restore original startup scripts'),
    ('', ' '),
    ('Enable', 'Assign external controller to Player 1'),
    ('Disable', 'Assign internal controller to Player 1'),
]

install_info = '''Launch scripts for compatible games will be modified. \
The originals will be moved to <Port Name>.sh.orig (do not delete them). The \
original files can be restored by choosing Uninstall from the menu. \
Continue?'''

uninstall_info = '''Launch scripts for compatible games will be modified. \
The originals will be moved to <Port Name>.sh.orig (do not delete them). The \
original files can be restored by choosing Uninstall from the menu. \
Continue?'''

enable_info = '''HackSDL is enabled. If any external controllers are \
connected when hack-enabled games launch, the first external controller will \
be assigned to Player 1, and the internal controller will be assigned to the \
last player.'''

disable_info = '''HackSDL is disabled. Player 1 will be assigned to the \
port's default controller even for hack-enabled games.'''


finished = False
while not finished:
  resp, choice = d.menu('Controller Setup -- press Start to choose. GTA and Iconoclasts external monitor hacks are permanently enabled', 20, 60, choices=menu)

  if resp == d.OK:
    if choice == 'Install':
      resp2 = d.yesno(install_info, 10, 60)

      if resp2 == d.OK:
        ports = call([pmhacks_port_dir+'/install/install-all.bash',
                      ports_dir])
        if len(ports)==0:
          msg = "Operation complete. No ports were modified."
        else:
          msg = "Operation complete. The following ports were modified: " \
                + ', '.join(ports) + '.'
        d.msgbox(msg, 15, 60)
      else:
        d.msgbox("Operation cancelled", 10, 60)
    elif choice == 'Uninstall':
      resp2 = d.yesno(uninstall_info, 10, 60)

      if resp2 == d.OK:
        ports = call([pmhacks_port_dir+'/install/uninstall-all.bash',
                      ports_dir])
        if len(ports)==0:
          msg = "Operation complete. No ports were modified."
        else:
          msg = "Operation complete. The following ports were restored: " \
                + ', '.join(ports) + '.'
        d.msgbox(msg, 15, 60)
      else:
        d.msgbox("Operation cancelled", 10, 60)

    elif choice == 'Enable':
      with open(flag_file, 'w') as f:
        f.write('')
      d.msgbox(enable_info, 10, 60)
      finished = True

    elif choice == 'Disable':
      try:
        remove(flag_file)
      except:
        pass
      d.msgbox(disable_info, 10, 60)
      finished = True

  else:
    finished = True

