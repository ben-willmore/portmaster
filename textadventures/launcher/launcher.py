#!/usr/bin/env python3

from os import listdir
from os.path import realpath, dirname
from subprocess import run
import json
import dialog

port_dir = dirname(dirname(realpath(__file__)))
launcher_dir = port_dir + '/launcher'
game_dir = port_dir + '/gamedata'
favorites_file = port_dir + '/gamedata/favorites.json'

d = dialog.Dialog(dialog=port_dir+'/whiptail/whiptail',
                  compat='whiptail')

## Main menu

def load_favorites(favorites_file):
  try:
    with open(favorites_file, 'r') as json_file:
      favorites = json.load(json_file)
  except BaseException as err:
    raise(err)
    favorites = []
  return favorites

def check_favorites(games, favorites):
  favorites.sort(key=str.casefold)
  present = []
  for favorite in favorites:
    if favorite in games:
      present.append(favorite)
    else:
      print('Removing missing game %s from favorites' % favorite)
  save_favorites(favorites_file, present)
  return present

def save_favorites(favorites_file, favorites):
  with open(favorites_file, 'w') as json_file:
    favorites = json.dump(favorites, json_file)

def get_gamelist(game_dir):
  games = listdir(game_dir)
  games.sort(key=str.casefold)
  valid = []
  for game in games:
    if game=='favorites.json':
      pass
    else:
      valid.append(game)
  return valid

def fmt_game(filename, favorites=None):
  bits = filename.split('.')
  name = '.'.join(bits[:-1]) # + ' (' + bits[-1] + ')'
  if favorites and filename in favorites:
    name = name + ' *'
  return name

def games_menu(games, favorites, favorites_only=False):
  if favorites_only:
    title = 'Favorites - choose game to launch and press Start:'
    menu = {'all': 'Show all games'}
    lst = favorites
    
  else:
    title = 'Choose game to launch and press Start:'
    menu = {'fav': 'Show favorites only'}
    lst = games

  menu.update({'edit': 'Edit favorites',
              'null': ' '})

  menu.update({str(i+1): fmt_game(game) for i, game in enumerate(lst)})
  filenames = {str(i+1): game for i, game in enumerate(lst)}

  resp, choice = d.menu(title, 21, 55, 0,
                        choices=menu.items(), notags=True)

  if resp == d.OK:
    if choice == 'all':
      library_menu(games, favorites)
    elif choice == 'fav':
      favorites_menu(games, favorites)
    elif choice == 'edit':
      favorites = choose_faves(games, favorites)
      favorites_menu(games, favorites)
    elif choice == 'null':
      games_menu(games, favorites, favorites_only=favorites_only)
    else:
      ext = filenames[choice].split('.')[-1].lower()
      if ext in ('ulx', 'gblorb'):
        bin = 'glulxe'
      elif ext in ['z'+str(i) for i in range(1, 9)]:
        bin = 'frotz'
      elif ext in ('zblorb', 'dat'):
        bin = 'frotz'
      elif ext in ('gam', 'tads'):
        bin = 'frob'

      run([port_dir + '/' + bin +'/' + bin, game_dir+'/'+filenames[choice]])

def favorites_menu(games, favorites):
  games_menu(games, favorites, favorites_only=True)

def library_menu(games, favorites):
  games_menu(games, favorites, favorites_only=False)

def choose_faves(games, favorites):
  menu = [(str(i+1), fmt_game(game), game in favorites) \
          for i, game in enumerate(games)]
  filenames = {str(i+1): game for i, game in enumerate(games)}

  title = 'Edit favorites and press Start to confirm:'
  resp, choices = d.checklist(title, 21, 55, 12, choices=menu, notags=True)

  if resp == d.OK:
    favorites = [filenames[c] for c in choices]
    favorites = check_favorites(games, favorites)
    save_favorites(favorites_file, favorites)
  return favorites


games = get_gamelist(game_dir)
favorites = load_favorites(favorites_file)
favorites = check_favorites(games, favorites)

if len(favorites)>0:
  favorites_menu(games, favorites)
else:
  library_menu(games, favorites)
#  favorites = choose_faves(games, favorites)
#  favorites_menu(games, favorites)

