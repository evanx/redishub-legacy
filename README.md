
## redishub.com

A deployment of https://github.com/evanx/rquery

Notable features:
- Secret token authentication for adhoc ephemeral keyspaces
- Identity management via Telegram.org chat bot (`@redishub_bot`)
- Access secured via client-authenticated SSL

TODO:
- grant and revoke account access (via Bot)
- keyspace role-based access control

Future plans:
- Enable "lambas" to be deployed to `apps.redishub.com`

### Goals 

Build a site "redishub.com" with a foundational HTTP service for accessing and mutating Redis keys in a hosted "keyspace."

Provide a web admin console to inspect and manage keys.

Enable hosted "apps" to be configured, deployed and managed. These have managed access/permissions to one or more keyspaces. Allow keyspaces to be grouped for access control purposes.

### Status

UNSTABLE, INCOMPLETE

### Documentation

See: https://github.com/evanx/rquery

