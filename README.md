
## redishub.com

Try: https://demo.redishub.com/register-expire

Note that this endpoint returns JSON, so you'll want a JSON viewer extension installed in your browser otherwise it's pretty unusable.

Documentation: https://github.com/evanx/rquery

Note that (insecure) HTTP access to all RedisHub domains, and some other URLs, are redirected to this info page.

### Goals 

Build a site "redishub.com" with a foundational HTTP service for accessing and mutating keys in a hosted Redis "keyspace." 

A keyspace is an online database accessible via Redis-style commands, and can be Redis i.e. in-memory, or disk-based e.g. via ssdb.io.

User stories:
- Use a free hosted Redis "keyspace" for low-volume ephemeral purposes (currently Redis so in-memory i.e. very fast)
- Deploy your own private "redishub" instance using the `rquery` opensource implementation, as used by Redishub

Potential uses of keyspaces:
- serverless backend database 
- storing encrypted data
- public/private online message hub
- centralised logging, monitoring and alerting purposes
- aggregated analytics

Future user stories:
- encrypted keys (using client cert)
- Manage the account admins and users
- Manage access to keyspaces
- Group/classify keyspaces for access control purposes
- Web admin console to inspect and manage keys
- Use disk-based keyspaces for archival
- Manage auto-archival of keys
- Enable a durable transaction log facilicity with playback for recovery
- Deploy Redishub "bots" to `bots.redishub.com` to build Redis-driven serverless backends
- Page bots generate web pages from React templates, populated with data from Redishub 

Redishub bots are special ES2016 scripts that use keyspaces for:
- pulling their configuration
- pushing logging messages e.g. info and errors
- pushing metrics e.g. for response time histograms, user geo distribution, et al
- messaging via Redis lists e.g. for microservice app architecture
- storing application state e.g. to support stateless microservices for auto-scaling
- persistent data storage via Redis keys e.g. values, lists, sets, sorted sets, hashes, geo et al

Related specification: https://github.com/evanx/component-validator

### FAQ 

<b>Q. What is RedisHub?</b> 
<br><b>A.</b> My pet project, to use my favourite toys, namely Redis, Node, React and ES2016, to explore security, servers, microservices, monitoring, logging, metrics and messaging.

<b>Q. What is a RedisHub keyspace?
<br>A.</b> An online Redis database partition, accessed via HTTPS.

<b>Q. What technology is behind a RedisHub keyspace?
<br>A.</b> Currently a multi-tenanted Redis instance. Maybe later a dedicated Redis instance, Redis Cluster and/or disk-based implementation such as https://ssdb.io.

<b>Q. Why use a Redis database rather than SQL?
<br>A.</b> Redis is the most popular NoSQL database. It supports abstract data structures which are well understood and pretty fundamental, e.g. sets, sorted sets, lists, hashes and geos.

<b>Q. Why use a hosted Redis service rather than one's own?
<br>A.</b> Actually Redishub doesn't offer hosted Redis instances per se (yet). It addresses some use cases for an online storage/messaging service.

<b>Q. But isn't Redis just for caching?
<br>A.</b> Certainly Redis excels at caching and is widely used for this. Actually it is an in-memory "data structure server." It has many usecases.

<b>Q. What about ACID?
<br>A.</b> We wish to support specific application transactions that are guaranteed to be durable, e.g. via a disk-based logging database. This a trade-off on performance in favour of durability.

<b>Q. What are Redishub bots?
<br>A.</b> These are envisaged as Redis-based serverless lambdas that can be composed into microservices and apps. The platform handles identity, authorisation, configuration, deployment, logging, metrics and messaging. However, a key simplication is that Redis is used across the board for all these concerns. Therefore the same UI tool for editing configuration, can be used for editing application data. Also tools to view data can be applied to multiple aspects of the platform.


### Status

UNSTABLE, INCOMPLETE


### Related

See: https://github.com/evanx/rquery

Notable features (June 2016):
- Register-expire for adhoc ephemeral keyspaces
- Identity verification via Telegram.org chat bot `@redishub_bot`
- Access secured via client-authenticated SSL (secure.redishub.com)
- Generate tokens for Google Authenticator 

### Documentation

See: https://github.com/evanx/rquery

