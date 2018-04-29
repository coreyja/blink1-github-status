# blink1-github-status

## Crontab

Every five minutes
It runs everything through bash and sources the bash profile to get rbenv setup and everything.
Also manually includes the ENV var necessary for authentication.

```bash
*/5 * * * * bash -c "source ~/.bash_profile >/dev/null 2>/dev/null && cd ~/Projects/blink1-github-status && BLINK1_GITHUB_TOKEN=FAKE_TOKEN bundle exec ./exe/set_light.rb coreyja/glassy-collections master >/dev/null 2>/dev/null"
```
