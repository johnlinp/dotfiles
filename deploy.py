import os
import sys
import shutil
import glob


def link_entry(entry):
	os.symlink(os.path.abspath(entry), get_dst_path(entry))


def is_ignored(entry):
	src_basename = os.path.basename(entry)
	return src_basename in ['deploy.py', 'README.md']


def get_dst_path(entry):
	home_dir = os.path.expanduser('~')
	return os.path.join(home_dir, '.' + entry)


def is_dst_exist(entry):
	return os.path.exists(get_dst_path(entry))


def is_dst_same_file(entry):
	return os.path.samefile(entry, get_dst_path(entry))


def get_backup_dir():
	return os.path.abspath('backup')


def backup_dst(entry):
	backup_dir = get_backup_dir()
	if not os.path.exists(backup_dir):
		os.mkdir(backup_dir)
	backup_full_path = os.path.join(backup_dir, entry)
	backup_dirname = os.path.dirname(backup_full_path)
	if not os.path.exists(backup_dirname):
		os.makedirs(backup_dirname)
	dst_path = get_dst_path(entry)
	shutil.copyfile(dst_path, os.path.join(backup_dir, entry))
	os.remove(dst_path)


def is_already_deployed(entry):
	if not is_dst_exist(entry):
		return False
	return is_dst_same_file(entry)


def deploy_single(entry, start, log):
	if is_ignored(entry):
		return

	if not os.path.exists(entry):
		raise Exception('no such file: ' + entry)
	elif os.path.isfile(entry):
		if is_already_deployed(entry):
			return
		if is_dst_exist(entry):
			print('backup', entry)
			log['backup'] += 1
			backup_dst(entry)
		print('deploy', entry)
		link_entry(entry)
		log['deploy'] += 1
	elif os.path.isdir(entry):
		if not is_dst_exist(entry):
			return
		entries = glob.glob(os.path.join(entry, '*'))
		deploy_many(entries, entry, log)
	else:
		raise Exception('unsupported file type: ' + entry)


def deploy_many(entries, start, log):
	for entry in entries:
		deploy_single(entry, start, log)


def main(argv):
	if len(argv) == 1:
		print('usage:')
		print('    python deploy.py all')
		print('    python deploy.py <config1> <config2> <config3> ...')
		return
	elif argv[1] == 'all':
		entries = glob.glob('*')
	else:
		entries = argv[1:]

	log = {'deploy': 0, 'backup': 0}
	deploy_many(entries, '', log)

	if not log['deploy']:
		print('nothing happened')
	if log['backup']:
		print('the backup files are in', get_backup_dir())


if __name__ == '__main__':
	main(sys.argv)
