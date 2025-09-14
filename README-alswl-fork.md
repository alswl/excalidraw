# Excalidraw(forked)

Using this fork to add some features that I need.

- [x] Self-host backend
- [x] Better Dockernized
- [x] Chinese font support (after v0.18.0, using official way to load font `xiaolai`)

more description in [Self hosted online collaborative drawing platform Excalidraw | Log4D](https://en.blog.alswl.com/2022/10/self-hosted-excalidraw/) and [私有化在线协同画图平台 Excalidraw | Log4D](https://blog.alswl.com/2022/10/self-hosted-excalidraw/)

## Branch management

```
Branches:

master: last used upstream, it will be related with upstream release tag
feat/$(name): feature branch, maybe deleted
feat/$(upstream-version)-$(name): feature branch, related to upstream version, rebased
tmp/*: temporary branch, maybe deleted

Tags:

$(upstream-version)-fork: # released tag
```

## Current active feature branch

Long live features branch (since v0.18.0):

- feat/http-backend
- feat/env-dynamic-in-docker-container
- feat/fork-docs

Archived:

- feat/chinese-font-fork-feat (archived)

Deprecated features:

- feat/chinese-font-fork-feat
- feat/chinese-font-support (active)
  - for upstream
- feat/self-host-backend-origin
  - feat/self-host-backend-origin-v0.14.2 (active)
