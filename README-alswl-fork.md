# Excalidraw(forked)

Using this fork to add some features that I need.

- [x] Self-host backend
- [x] Chinese font support

more description in [Self hosted online collaborative drawing platform Excalidraw | Log4D](https://en.blog.alswl.com/2022/10/self-hosted-excalidraw/) and [私有化在线协同画图平台 Excalidraw | Log4D](https://blog.alswl.com/2022/10/self-hosted-excalidraw/)

## Branch management

```
upstream(excalidraw/excalidraw):
    release tag

fork:
    master: last used upstream, it will be related with upstream release tag
    fork: master + features branches
    release/$(version)-$(build-version): based on upstream release tag, and merge with features
    feat/$(name): feature branch, maybe deleted
    feat/$(name)-long-live: feature branch, will not be deleted, rebased with every latest master
    tmp/*: temporary branch, maybe deleted
```

## Current active feature branch

- feat/chinese-font-fork-feat
- feat/chinese-font-support (active)
  - for upstream
  - feat/chinese-font (deprecated)
  - feat/chinese-font-for-v0.12.0 (deprecated, merged to release)
- feat/self-host-backend-origin
  - feat/self-host-backend (deprecated)
  - feat/self-host-new-pr-for-v0.12.0 (deprecated, merge to release)
  - feat/self-host-backend-origin-v0.14.2 (active)
- feat/env-dynamic-in-docker-container
