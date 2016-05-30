
### How to get tail characters of a cert PEM

```shell
cat ~/.redishub/live/cert.pem | tail -2 | grep '^\w' | sed 's/=*$//' | tail -c-12
```
where we exclude any '=' Base64 padding at the end of the last line of the PEM.

For example:
```shell
cat ~/.redishub/live/cert.pem | tail -2
```
```
JepFtfage+nEzTOH9uNXDtXTqESABt1vBLf1+LOhjyzY1EI2M7QaVBU=
-----END CERTIFICATE-----
```
```shell
cat ~/.redishub/live/cert.pem | tail -2 | grep '^\w' 
```
```
JepFtfage+nEzTOH9uNXDtXTqESABt1vBLf1+LOhjyzY1EI2M7QaVBU=
```
```shell
cat ~/.redishub/live/cert.pem | tail -2 | grep '^\w' | sed 's/=*$//' 
```
```
JepFtfage+nEzTOH9uNXDtXTqESABt1vBLf1+LOhjyzY1EI2M7QaVBU
``` 
```shell
cat ~/.redishub/live/cert.pem | tail -2 | grep '^\w' | sed 's/=*$//' | tail -c-12
```
```
1EI2M7QaVBU
```

