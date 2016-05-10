
## redishub.com

### Goals 

Build a site "redishub.com" with a foundational HTTP service for accessing and mutating keys in a hosted Redis "keyspace." 

User stories:
- Use a hosted Redis "keyspace" for specific low-volume purposes.

Future user stories:
- Web admin console to inspect and manage keys.
- Keyspaces grouped for access control purposes.
- Disk-based keyspaces for archival.
- Support auto-archival of keys.
- Support durable transaction log recording, with replay for recovery
- Deploy "bots" that operate on keyspaces 


### Status

UNSTABLE, INCOMPLETE


### Implementation

A deployment of https://github.com/evanx/rquery

Notable features (June 2016):
- Generate tokens for Google Authenticator 
- Register-expire for adhoc ephemeral keyspaces
- Identity verification via Telegram.org chat bot @redishub_bot`
- Access secured via client-authenticated SSL (secure.redishub.com)

TODO (June 2016):
- refactor (separate auth modules for OTP, Telegram)
- grant and revoke account access (via Bot)
- keyspace role-based access control

Future plans:
- Enable "lambas" to be deployed to `apps.redishub.com`
-  lambda keyspace access permissions

### Documentation

See: https://github.com/evanx/rquery

