
## redishub.com

### Goals 

Build a site "redishub.com" with a foundational HTTP service for accessing and mutating keys in a hosted Redis "keyspace." 

User stories:
- Use a hosted Redis "keyspace" for specific low-volume purposes.

Future user stories:
- Manage the account admins and users
- Manage access to keyspaces
- Group/classify keyspaces for access control purposes.
- Web admin console to inspect and manage keys.
- Disk-based keyspaces for archival.
- Manage auto-archival of keys.
- Provide a durable transaction log facilicity with playback for recovery


### Status

UNSTABLE, INCOMPLETE


### Implementation

A deployment of https://github.com/evanx/rquery

Notable features (June 2016):
- Register-expire for adhoc ephemeral keyspaces
- Identity verification via Telegram.org chat bot @redishub_bot`
- Access secured via client-authenticated SSL (secure.redishub.com)
- Generate tokens for Google Authenticator 

TODO (June 2016):
- refactor (separate auth modules for OTP, Telegram)
- grant and revoke account access (via Bot)
- keyspace role-based access control

Future plans:
- Enable "lambas" to be deployed to `apps.redishub.com`
-  lambda keyspace access permissions

### Documentation

See: https://github.com/evanx/rquery

