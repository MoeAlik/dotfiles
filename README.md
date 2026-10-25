going to start adding all my configs in one place

things todo:
- [x] support dir configs instead of one off files (think of vscode)
- [ ] adding color to pretty printing
- [x] more commands
- [ ] rake?
- [x] trying to make adding commands ez
- [x] formatter
- [x] what kind of intellisense/LSP for ruby?
- [x] dont forget i have project files now
- [x] changed module name to install but method is still `set`
- [x] git hooks?
- [ ] github actions?
- [ ] logger class to space out text evenly etc
- [x] can toml setting groups have custom commands?
- [ ] do i unflatted project files?
- [ ] each machine needs a different path for smth like vscode, need to store more logic for profiles
- [ ] get rid of globals
- [ ] hard coding strings everywhere, I want to use reserved const vars when hashing from config. can store this stuff into a special class instead of a global hash
- [ ] can use branches for the pathnames and keep everything else consistent
- [ ] can we make any of this config driven?
- [ ] prety print the spacing when it comes to githooks
- [ ] clangformat is standalone but it could be semantically grouped with other cpp configs
- [ ] is parse really doing anything, it should be a pre-action check that makes sure everything is fine. i should be using it to sanity check adding clang format without issue
- [ ] should start thinking about testing too
- [ ] i dont want to manually edit the toml to add something, it should be apart of the CLI??
- [ ] githooks didnt work on pc prob cuz no perms