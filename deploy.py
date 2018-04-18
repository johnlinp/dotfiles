#!/bin/python3

import os
import sys
import shutil
import glob


def list_entries():
    black_list = ['deploy.py', 'README.md', 'backup']
    entries = glob.glob('*')
    return [entry for entry in entries if entry not in black_list]


def link_entry(entry):
    os.symlink(os.path.abspath(entry), get_dst_path(entry))


def get_dst_path(entry):
    home_dir = os.path.expanduser('~')
    return os.path.join(home_dir, '.' + entry)


def is_dst_exist(entry):
    return os.path.exists(get_dst_path(entry))


def is_dst_same_file(entry):
    return os.path.samefile(entry, get_dst_path(entry))


def get_backup_dir():
    return os.path.abspath('backup')


def get_backup_path(entry):
    backup_dir = get_backup_dir()
    return os.path.join(backup_dir, entry)


def backup_dst(entry):
    backup_full_path = get_backup_path(entry)
    backup_dirname = os.path.dirname(backup_full_path)
    if not os.path.exists(backup_dirname):
        os.makedirs(backup_dirname)
    dst_path = get_dst_path(entry)
    shutil.copyfile(dst_path, backup_full_path)
    os.remove(dst_path)


def is_already_deployed(entry):
    if not is_dst_exist(entry):
        return False
    return is_dst_same_file(entry)


def deploy_single(entry):
    if not os.path.exists(entry):
        raise Exception('no such file: {}'.format(get_dst_path(entry)))

    if os.path.isfile(entry):
        if is_already_deployed(entry):
            print('    already deployed: {}'.format(get_dst_path(entry)))
            return
        if is_dst_exist(entry):
            print('    making backup: {} -> {}'.format(get_dst_path(entry), get_backup_path(entry)))
            backup_dst(entry)
        print('    deploying: {}'.format(get_dst_path(entry)))
        link_entry(entry)
    elif os.path.isdir(entry):
        if not is_dst_exist(entry):
            print('    directory does not exist: {}, do not deploy'.format(get_dst_path(entry)))
            return
        entries = glob.glob(os.path.join(entry, '*'))
        for entry_ in entries:
            deploy_single(entry_)
    else:
        raise Exception('unsupported file type: {}'.format(get_dst_path(entry)))


def deploy_many(entries):
    for entry in entries:
        print('deploying entry {}:'.format(entry))
        deploy_single(entry)


def main(argv):
    if len(argv) == 1:
        print('usage:')
        print('    ./deploy.py all')
        print('    ./deploy.py <config1> <config2> <config3> ...')
        return

    if argv[1] == 'all':
        entries = list_entries()
    else:
        entries = argv[1:]

    deploy_many(entries)


if __name__ == '__main__':
    main(sys.argv)
