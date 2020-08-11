This document describes the testbed functionality.

Fairris is a simple web interface for this testbed, available at localhost:8080 after starting the containers using docker-compose. It represents a simple client, as it might be implemented in workflow systems or other kind of clients for specific disciplines. It has the following functionalities:

- Vieweing FDOs
    - Any FDO registered within Fairris is visible within the application. The content of the records can be displayed.
- [Creating FDO for an annotated image](pageannotation.md)
    - Keywords: Aristoteles A04, PageAnnotation, XML, existing data
- [Search functionality](search.md)
- [Collection functionality](collection.md)
    - TODO

# General notes

Every attribute name of the profile is in practice represented by a pid, not a string. The attibute names here are just for readability. A pid is a unique string. An attributes pid has a type (which has also its own PID). The type defines the values allowed for an attribute. According to the [PID KernelInformation Recommendations][recommendations], a value should be indivisible, similar to primitive types in programming languages. This is illustrated in the following figure:

![](images/dtr_attributes.drawio.svg)

A profile defines mandatory and optional attributes. Some attributes are allowed to occur multiple times. In practice this means that the value may be some kind of array, depending of the used technologies (i.e. a JSON array). The following figure shows the used profile.

![](images/pageannotation_record.drawio.svg)

[recommendations]: https://www.doi.org/10.15497/A5BCD108-ECC4-41BE-91A7-20112FF77458
