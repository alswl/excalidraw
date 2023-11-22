# Excalidraw(forked)

Using this fork to add some features that I need.

- [x] Self-host backend
- [x] Chinese font support
- [x] Dockernized

more description in [Self hosted online collaborative drawing platform Excalidraw | Log4D](https://en.blog.alswl.com/2022/10/self-hosted-excalidraw/) and [私有化在线协同画图平台 Excalidraw | Log4D](https://blog.alswl.com/2022/10/self-hosted-excalidraw/)

## Branch management

```
upstream(excalidraw/excalidraw):
    release tag

fork:
    master: last used upstream, it will be related with upstream release tag
    feat/$(name): feature branch, maybe deleted
    feat/$(upstream-version)-$(name): feature branch, related to upstream version, rebased
    tmp/*: temporary branch, maybe deleted
    $(upstream-version)-fork: # released tag
```

## Current active feature branch

Long live features branch:

- feat/env-dynamic-in-docker-container
- feat/add-basic-http-backend
- feat/chinese-font-fork-feat
- feat/docs-long-live

Deprecated features:

- feat/chinese-font-fork-feat
- feat/chinese-font-support (active)
  - for upstream
- feat/self-host-backend-origin
  - feat/self-host-backend-origin-v0.14.2 (active)
