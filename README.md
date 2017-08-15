# Static binary build of GF

This `Dockerfile` builds a static binary of the latest version of GF
available on Hackage.

It uses Alpine Linux to more easily generate static binaries with GHC.

Just run `make` with Docker installed and you will receive a
`gf` binary.
