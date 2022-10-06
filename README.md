# postlogue

Simple webhook to shell handler using Rust and Rocket.rs

## Settings
```yaml
port: 9090
debug: true
flowsDir: foo
```

## Notes on Gitea:
* Webhook has a `ref` key if it's a commit
* Webhook has a `action` key for PR's