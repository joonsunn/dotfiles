# SSH stow notes

## Generating ssh key pairs

```sh
ssh-keygen -t ed25519 -C "your_email@example.com"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
ssh -T git@github.com
ssh -T git@work # if alternative ssh profile is set up
```
