# SAP S/4 Metadata Extraction

## Motivation

Azure data engineers usually don't have much experience working with SAP data. Moreover, they are often not granted access to the source SAP ERP for exploration. Based on our experience from previous projects, we selected a set relevant SAP tables and Azure Data Factory extraction pipelines to bring the most important SAP ERP object metadata to Azure Data Lake, thereby helping data engineers explore SAP data sources, specific fields, and their relationships.

In the first stage, the base SAP tables are ingested into Azure Blob storage. From here, they can be further process by a Data platform of choice to provide an exhaustive data model representing all relationships between SAP objects of a business value, which are to be extracted.

## Pre-built Azure DataFactory (ADF) Pipelines

We provide you with a pre-built configuration to set up the metadata extraction pipelines in your ADF quickly.

### Extracted tables list

Our metadata pipeline extracts 26 tables contained in every SAP ERP which can be composed into advanced easy-to-understand DD (Data dictionary) data model.

Note, that the tables are not always exported exactly as they are stored in the ABAP, but we sometimes apply simple filters on them in order to minimize amount of the ingested data.

The extracted tables are the following:

| Table name | Description | Category |
|---|---|---|
| **DD01L** | Domain data | Domains |
| **DD02B** | DD: Header for Structured Objects	| CDS views |
| **DD02L** | Detailed metadata of SAP tables | Tables |
| **DD02T** | SAP DD: SAP Table Texts | Tables |
| **DD03L** | Field definition of tables | General |
| **DD03ND** | DD: Attributes of a Node of a Structured Object | CDS views |
| **DD04T** | DD: Descriptions of fields | CDS views |
| **DD05B** | DD: Associations for Structured Objects: Fields | CDS views |
| **DD05S** | Foreign key fields | Tables |
| **DD07T** | DD: Texts for Domain Fixed Value | Domains |
| **DD08B** | DD: Associations (Headers) for Structured Objects	 | CDS views |
| **DD08L** | R/3 DD: relationship definitions | Tables |
| **DD08T** | Texts on the relationship definitions	| Tables |
| **DD26S** | Base tables and foreign key relationships for a view | CDS views |
| **DD27S** | Fields in an Aggregate (View, MC Object, Lock Object) | CDS views |
| **DDDDLSRCT** | DDL Source Texts | CDS views |
| **DDHEADANNO** | DD: Annotations: Header | CDS views |
| **DDLDEPENDENCY** | DD: Objects in a DDL Source | CDS views |
| **DF14L** | Application Components | Application components |
| **DD14T** | Business Application Component Names | Application components |
| **RODSAPPL** | DataSource Application Components | Extractors |
| **RODSAPPT** | Texts for Application Components of a DataSource | Extractors |
| **ROOSFIELD** | DataSource Fields | Extractors |
| **ROOSOURCE** | Table Header for OLTP Sources | Extractors |
| **TADIR** | Directory of Repository Objects | General |
| **TDEVC** | Packages | General |


## Installation

### 1. ADF Linked Services Setup

1. In the ADF linked service files (_linkedService_ directory), adjust the name of the integration runtime (currently _sap-demo-ir_) to the name used in your environment
1. Add the path to your datalake into the _sapdemo_datalake_ linked service file
1. (optional) Rename all linked services and update the references in all the other ADF files. It can be easily done by searching and replacing the `"s18_` prefix (including the double quotes) and the `"sapdemo_datalake"` string (including the double quotes) names in all the repository files. Don't forget to __rename the linked service definition files__ accordingly.
1. Import all the provided ADF linked services to your ADF in your Azure environment
1. Open each newly created linked service, enter your specific connection details and click the "Test connection" button
1. If all the connections work, save and __publish__ changes to your ADF

### 2. ADF Dataflows, DataSets, Pipelines

1. (optional) Rename all the remaining files and update the references in all the other ADF files. It can be easily done by searching and replacing the `"s18_` prefix (including the double quotes) and the `"sapdemo_datalake"` string (including the double quotes) names in all the repository files. Don't forget to __rename the dataflow/dataset/pipeline definition files__ accordingly.
1. Set the target datalake container by searching the `"container": "raw"` string (including the double quotes) and replacing it with the container name of your preference
1. Set the target path to write the metadata parquet files into by searching the `"s18/metadata/` string (including the double quotes and trailing `/`) and replacing it with the path of your preference.
1. Import all the modified files from the _dataset_, _dataflow_ and _pipeline_ directories to your ADF.
1. Save and __publish__ changes to your ADF

### 3. Initial Extraction

Run the _s18_metadata/s18_01_extract_data_ pipeline to extract all the necessary metadata and write them to the datalake container
