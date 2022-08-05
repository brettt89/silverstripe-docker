# Development of `brettt89/silverstripe-docker` images

This repository has been setup to use Github Actions to automatically test and release new builds using Git functionality. These instructions can be found in the `.github/` directory.

`develop.yml` contains Development tests which are run on every pull-request that contains changes to files in `src/`, `tests/` or `.github/`. These tests run a Silverstripe website (Both CMS 3 and CMS 4) on each image and confirms image is working as expected by executing a `dev/build` against the installation.

`deploy.yml` contains the Release process which is run when a new "tag" is created. Upon the tag being created, this workflow will perform a final Silverstripe CMS application test (Framework 4 only) on each Image before building all images across defined architectures (e.g. `amd64`, `arm64`). If these builds succeed, they are automatically pushed up to DockerHub as part of the CI/CD process.

## Making Changes

All changes should be submitted via Pull Requests to ensure development tests are executed for any changes made. This ensures that full test suite is executed against your changes before any release is made.

## Creating Releases

Releases can be triggerred by creation of a new tag/release on the repository. These tags/releases should *only* be created on the `master` branch for continuity.

>NOTE: The Release process will ignore tags that have `/` characters in them (E.g. The tag `3.1.2/beta` would be ignored).