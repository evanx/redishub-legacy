
### How to get tail characters of a cert PEM

```shell
cat ~/.redishub/live/cert.pem | tail -2 | grep '^\w' | sed 's/=*$//' | tail -c-12
```
where we exclude any '=' Base64 padding at the end of the last line of the PEM.

#### Explanation 

Get the last two lines of the PEM:
<b>
```shell
cat ~/.redishub/live/cert.pem | tail -2
```
</b>
Result:
```
JepFtfage+nEzTOH9uNXDtXTqESABt1vBLf1+LOhjyzY1EI2M7QaVBU=
-----END CERTIFICATE-----
```
We exclude the last line starting with '-'
<b>
```shell
cat ~/.redishub/live/cert.pem | tail -2 | grep '^\w' 
```
</b>
Result:
```
JepFtfage+nEzTOH9uNXDtXTqESABt1vBLf1+LOhjyzY1EI2M7QaVBU=
```
Remove any '=' Base64 padding at the end of the line:
<b>
```shell
cat ~/.redishub/live/cert.pem | tail -2 | grep '^\w' | sed 's/=*$//' 
```
</b>
Result:
```
JepFtfage+nEzTOH9uNXDtXTqESABt1vBLf1+LOhjyzY1EI2M7QaVBU
``` 
Take the last 12 characters only:
<b>
```shell
cat ~/.redishub/live/cert.pem | tail -2 | grep '^\w' | sed 's/=*$//' | tail -c-12
```
</b>
Result:
```
1EI2M7QaVBU
```

