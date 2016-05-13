
## RedisHub.com FAQ

<b>What is RedisHub?</b>
<br></b> My pet R&D project, to use my favourite toys, namely Redis, Node, React and ES2016, to explore security, servers, microservices, monitoring, logging, metrics and messaging.

<b>Who are you?</b>
<br></b> I'm a professional Node, React and Redis web developer and full stack engineer based in Cape Town, working on content sites for a major news publisher. In my spare time, I work on my Github projects that invariably align with my professional interests. Previously, I've been a Java enterprise developer, PostgreSQL DBA and Linux engineer. That's why I love bash shell so much ;)

<b>What technology is behind a RedisHub keyspace?
<br></b> Currently a multi-tenanted Redis instance. Later a multi-tenanted Redis Cluster, dedicated Redis instance, dedicated Redis Cluster, or disk-based implementation such as http://ssdb.io.

<b>Why use a Redis database rather than SQL?
<br></b> Redis is a popular and awesome NoSQL database. It's an in-memory database and so really fast. It supports abstract data structures which are well understood and pretty fundamental, e.g. sets, sorted sets, lists, hashes and geos. Having said that, I love SQL too and may use PostgreSQL for some transactional aspects of Redishub.

<b>What about ACID?
<br></b> Atomicity, consistency, isolation and durability is that offered by Redis or other back end engines. This is a trade-off sacrificing performance in favour of durability, e.g. potentially loosing a second's worth of transactions in the event a server crash, versus the heavy performance cost of a disk sync on every transaction. We wish to support highly durable transactions since this is an important use case e.g. to record financial transactions in ecommerce. However, I wish firstly to address back end requirements for content, gaming and analytics use cases, e.g. optionally trading off performance for database size using ssdb.

<b>But isn't Redis just for caching?
<br></b> Certainly Redis is the leading caching server. But actually Redis is an in-memory "data structure server." As such, it has many use cases, including fast shareable data storage, analytics, geo-spatial processing, synchronisation, queuing and messaging.

<b>Why use a hosted Redis service rather than one's own?
<br></b> Actually Redishub doesn't offer hosted Redis instances (yet). It addresses some use cases where an online serverless storage/messaging service is convenient. Perhaps I'll find it useful, and if so perhaps other Indie developers will too, although I should be under no allusions in that respect.

<b>Will you ever offer a hosted Redis service?
<br></b> There are other PaaS vendors that offer hosted Redis at scale, e.g. AWS ElastiCache. Nevertheless, I want to experiment with orchestrating Redis instances, clusters and replicas. However I'm more interested in orchestrating "bots" first.

<b>What are Redishub bots?
<br></b> These are envisaged as Redis-based serverless lambdas that can be composed into microservices and apps.
I'm choosing to define "bots" as server-side components which access one or more keyspaces. They must be stateless to enable auto-scaling. They will be written using a specific ES2016 framework, to simplify orchestration and management.

<b>How will Redishub support its bots?
<br></b> The platform should handle identity, authorization, configuration, deployment, logging, metrics and messaging. However, a major simplication is that Redis will be used across the board for all these concerns. For example, the same UI tool for inspecting and editing configuration, can be used for application data.

<b>Why would a developer use an indie service which might become abandonware?</b>
<br></b> That is a very good question. It would have to address specific use cases better than competing products from AWS and many others, and that is a tall order. But I'll be learning a great deal and boosting my professional skills and profile in the process. I'm keen to build something simple, interesting and fun. Computing resources are cheap. So I'm happy to offer a free, but necessarily resource limited service, to any number of developers, even if it costs me personally $500 per month on computing resources to support 100 developers, since that implies that Redishub is a successful project. Anyway I'd rather be acquired for a million dollars down the line, than try to make a few dollars here and there ;)

<b>Why Telegram.org?
<br></b> I've always liked the sound of Telegram, e.g. their security and openness. Also I have an Ubuntu phone, which has Telegram, but not others. Last but not least, I want to enter the Bot competion and maybe get lucky and win one of those prizes. "Then we'll be millionares!" as Homer says ;)
