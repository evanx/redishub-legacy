
### How to register a client cert 

```shell
curl -E ~/.redishub/privcert.pem https://secure.redishub.com/register-cert
```

#### Troubleshooting

```shell
openssl x509 -text -in ~/.redishub/privcert.pem | grep 'CN='
```
 
