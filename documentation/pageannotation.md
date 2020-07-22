# PageAnnotation data

Datatype: Image file (i.e. image/tiff)

Metadata type: PageAnnotation+XML

# Ingest: Record creation

> Assumption: The image file and the metadata xml file are already available at the fictive URLs https://imag.es/image.tiff and https://page.anno/annotation.xml.

> Note: Every Attribute of the profile is in practice represented by a pid, not a string.  The attibute names here are just for readability. A pid is a unique string.
> 
> An attributes pid represents a type and is unique within one profile. The type defines what the value may be, that can be assigned to an attribute. According to the [PID KernelInformation Recommendations][recommendations], a value should be indivisible, similar to primitive types in programming languages.
> 
> Syntax is: `attribute: possible Value Type(s)`

![](images/dtr_attributes.drawio.svg)

This is how a profile looks like:

![](images/pageannotation_record.drawio.svg)

[recommendations]: TODO
