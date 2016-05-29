
### How to get tail characters of a cert PEM

```shell
cat ~/.redishub/live/cert.pem | tail -2 | grep '^\w' | tail -c-12
```
