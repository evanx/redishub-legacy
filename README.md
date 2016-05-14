
## redishub.com

Try: https://demo.redishub.com/register-expire

Note that this endpoint returns JSON, so you'll want a JSON viewer extension installed in your browser otherwise it's pretty unusable.

Documentation: https://github.com/evanx/rquery

Note that (insecure) HTTP access to all RedisHub domains, and some other URLs, are redirected to this info page.


### Status

UNSTABLE, INCOMPLETE


### FAQ

##### What is RedisHub?

My pet R&D project, to use my favourite toys, namely Redis, Node, React and ES2016, to explore security, servers, microservices, monitoring, logging, metrics and messaging.

##### Who are you?

I'm a web developer based in Cape Town, working on content sites for a news publisher, using Node, React and Redis. In my spare time, I work on my Github projects. Previously, I've been a Java enterprise developer, PostgreSQL DBA and Linux engineer. I'm also fond of bash shell programming. Find me at https://twitter.com/@evanxsummers.

##### What technology is behind a RedisHub keyspace?

Currently a multi-tenanted Redis instance. Later a multi-tenanted Redis Cluster, dedicated Redis instance, dedicated Redis Cluster, or disk-based implementation such as http://ssdb.io.

##### Why use a Redis database rather than SQL?

Redis is a popular and awesome NoSQL database. It's in-memory and so really fast. It supports data structures which are well understood and pretty fundamental, e.g. sets, sorted sets, lists, hashes and geos. Having said that, I love SQL too and may use PostgreSQL for some transactional aspects of Redishub.

##### What about ACID?

Atomicity, consistency, isolation and durability is that offered by Redis or other back end engines. This is a trade-off sacrificing performance in favour of durability, e.g. potentially loosing a second's worth of transactions in the event a server crash, versus the heavy performance cost of a disk sync on every transaction. 

We wish to support highly durable transactions since this is an important use case e.g. to record financial transactions in ecommerce. However, I wish firstly to address back end requirements for content, gaming and analytics use cases, e.g. optionally trading off performance for database size using ssdb.

##### But isn't Redis just for caching?

Certainly Redis is the leading caching server. But actually Redis is an in-memory "data structure server." As such, it has many use cases, including fast shareable data storage, analytics, geo-spatial processing, synchronisation, queuing and messaging.

##### Why use a hosted Redis service rather than one's own?

Actually Redishub doesn't offer hosted Redis instances (yet). It addresses some use cases where an online serverless storage/messaging service is convenient. Perhaps I'll find it useful, and if so perhaps other Indie developers will too, although I should be under no allusions in that respect.

##### Will you ever offer a hosted Redis service?

There are other PaaS vendors that offer hosted Redis at scale, e.g. AWS ElastiCache, RedisLabs, OpenRedis and RedisGreen. Nevertheless, I want to experiment with orchestrating Redis instances, clusters and replicas, and must do so to automate Redishub itself. However I'm more interested in serverless "bots" than Redis hosting per se.

##### What are Redishub bots?

These are envisaged as Redis-based lambdas that can be composed into microservices and apps.
I'm choosing to define "bots" as server-side components which access one or more keyspaces. 
They must be stateless to enable auto-scaling, but can store private and shared state in Redis of course. They must be written using a specific ES2016 framework, to simplify orchestration and management, e.g. configuration, keyspace access, logging and metrics.

##### How will Redishub support its bots?

The platform should handle identity, auth, configuration, deployment, logging, messaging, monitoring and scaling. A notable simplication is that Redis will be used across the board for all these concerns.

##### Why would a developer use an indie service which might become abandonware?

That is a very good question. It would have to address specific use cases better than competing products from AWS and many others, and that is a tall order. But I'll be learning a great deal and boosting my professional skills and profile in the process. I'm keen to build something simple, interesting and fun. Computing resources are cheap. So I'm happy to offer a free, but necessarily resource limited service, to any number of developers.

##### Why Telegram.org?

I've always liked the sound of Telegram, e.g. their security and openness. Also I have an Ubuntu phone, which has Telegram, but not others. Last but not least, I want to enter the Bot competion and maybe get lucky and win one of those prizes. "Then we'll be millionares!" as Homer says ;)


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
- Enable a durable transaction log facility with playback for recovery
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



### Related

See: https://github.com/evanx/rquery

Notable features (June 2016):
- Register-expire for adhoc ephemeral keyspaces
- Identity verification via Telegram.org chat bot `@redishub_bot`
- Access secured via client-authenticated SSL (secure.redishub.com)
- Generate tokens for Google Authenticator

### Documentation

See: https://github.com/evanx/rquery
