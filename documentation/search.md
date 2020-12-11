# Searching PID records

## Status: proof of concept

Indexing and searching is generally possible, but more in a "proof-of-concept" kind of state. The indexer, which is the part being not much more than a proof-of-concept, is currently improved for another use case, and the next version within the testbed will likely build on this new version.

The PIT-Service will send out a message on record changes, and the indexer will be notified, transform the record for elasticsearch and ingest it. You can search the index directly via the elastic APIs or using the Kibana web interface.

## Planning documents:

![](images/usecase_indexing.drawio.svg)

