# PageAnnotation data

Datatype: Image file (i.e. image/tiff)

Metadata type: application/json+ld, [Annotation Ontology](https://www.w3.org/TR/annotation-model/).

# Ingest: Record creation

> Assumption: The image file and the metadata files are already available under some certain URLs. There are multiple metadata files.

In the case of an annotated image, there must be two FDOs registered. One for the image itself, and one for the metadata. The image FDO has to point to the metadata, and the metadata object may have additional metdadata information attached. In the case of the annotation metadata, there is no further object referenced. Instead, it points to IRIs which are defining the semantic context and ontology. For all objects, the same profile is used. There is no enforcement to attach semantic context and ontology to the metadata. To define more strict assumptions, there would in practice be the need for a lot of profiles, which is not [recommended](recommendations). The following figure demonstrates in detail how metadata and data are connected.

![](images/connecting_metadata.drawio.svg)

[recommendations]: https://www.doi.org/10.15497/A5BCD108-ECC4-41BE-91A7-20112FF77458

## Evaluation

There are two things to consider in this approach:

1. The optional type hint (marked red) might be useful for parsing, but violates several recommendations and may lead to outdated information. Consider it deprecated.
2. This reuses a single profile for differend purposes. Discussion about this is needed.

Overall, this was the very first approach and will likely change soon. (PS: Due to a UI revamp it might be the case that this is currently not applicable in the Fairris UI (11.12.2020)).