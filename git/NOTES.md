# `git` stow notes

`~/.config/git/config` only works if `XDG_CONFIG_HOME` is set to it on MacOS, otherwise the configs need to go into `~/.gitconfig`.

Reference:

- <https://git-scm.com/docs/git-config>
- <https://nelson.cloud/.gitignore-isnt-the-only-way-to-ignore-files-in-git/>

If having mutiple gitconfigs (e.g. `~/.config/git/work/gitconfig_work`), can specify profile-specific ssh keys to produce folder based ssh keys usage, instead of having to create multiple ssh configs e.g. `git@gitlab_work`:

```properties
    [user]
        name = Joon Sunn Foo (Work)
        email = joonsunn.foo@work-email.com
        signingkey = ~/.ssh/id_ed25519_work.pub
    [core]
        sshCommand = "ssh -i ~/.ssh/id_ed25519_work"
```
