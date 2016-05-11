
## redishub.com

Try: https://demo.redishub.com

Note that (insecure) HTTP access to all RedisHub domains, and/or pathless URLs, are redirected to this info page.

### Goals 

Build a site "redishub.com" with a foundational HTTP service for accessing and mutating keys in a hosted Redis "keyspace." 

User stories:
- Use a hosted Redis "keyspace" for specific low-volume purposes.

Future user stories:
- Manage the account admins and users
- Manage access to keyspaces
- Group/classify keyspaces for access control purposes
- Web admin console to inspect and manage keys
- Use disk-based keyspaces for archival
- Manage auto-archival of keys
- Enable a durable transaction log facilicity with playback for recovery
- Deploy special "workers" to `apps.redishub.com` to build Redis-driven serverless backends
- "React workers" generate web pages from React templates, using data stored in Redishub 

Redishub workers are special ES2016 scripts that use keyspaces for:
- pulling their configuration
- pushing logging messages e.g. info and errors
- pushing metrics e.g. response time histograms
- messaging via Redis lists
- storing application state e.g. to support auto-scaling
- data storage via Redis keys e.g. for storing values, lists, sets, sorted sets and hashes

Related specification: https://github.com/evanx/component-validator


### Status

UNSTABLE, INCOMPLETE


### Related

See: https://github.com/evanx/rquery

Notable features (June 2016):
- Register-expire for adhoc ephemeral keyspaces
- Identity verification via Telegram.org chat bot @redishub_bot`
- Access secured via client-authenticated SSL (secure.redishub.com)
- Generate tokens for Google Authenticator 

### Documentation

See: https://github.com/evanx/rquery

