# How to use the release bundle
* Inspect `settings.yaml`. If they're not to your choosing, run the `setup` exec to re-generate it
* Put `settings.yaml` in some system path. (Maybe `/etc/postlogue/settings.yaml` ?)
* Run `postlogue -c <path_to_settings_file>` (Maybe with a service supervisor?)