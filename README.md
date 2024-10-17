# SAP ECC or S/4 Metadata Extraction

## Motivation

Azure data engineers usually don't have much experience working with SAP data. Moreover, they are often not granted access to the source SAP ERP for exploration. Based on our experience from previous projects, we selected relevant SAP tables and Azure Data Factory extraction pipelines to bring the most important SAP ERP object metadata to Azure Data Lake, thereby helping data engineers explore SAP data sources, specific fields, and their relationships.

## Pre-built Azure DataFactory (ADF) Pipelines

We provide you with a pre-built configuration to quickly set up the metadata extraction pipelines in your ADF. The SAP tables are extracted into Azure Blob Storage and can be further processed to provide a more developer-friendly data model.

Please note that, for some tables, we filter out unnecessary rows to minimize the amount of transferred data. Filters are defined within the ADF pipelines themselves.

## Extracted tables list

Our metadata pipeline extracts 26 tables that exist in every SAP ERP:

### General Tables

| Table name | Description |
|---|---|
| **DD03L** | Columns for tables and extractors |
| **TADIR** | Additional attributes of repository objects |

### Application Components & Packages

| Table name | Description |
|---|---|
| **DF14L** | Application components |
| **DD14T** | Application components texts |
| **TDEVC** | Packages |

### Domains

| Table name | Description |
|---|---|
| **DD01L** | Domains |
| **DD07T** | Domain texts |

### Extractors

| Table name | Description |
|---|---|
| **ROOSOURCE** | Extractors |
| **ROOSFIELD** | Extractor columns |
| **RODSAPPL** | Extractor components |
| **RODSAPPT** | Extractor components texts |

### CDSViews

| Table name | Description |
|---|---|
| **DDLDEPENDENCY** | CDSViews |
| **DD02B** | RAW (case sensitive) CDSView names	|
| **DDDDLSRCT** | CDSView texts |
| **DD03ND** | CDSView columns |
| **DD04T** | CDSView column texts |
| **DD08B** | CDSView associations	|
| **DD05B** | CDSView association conditions |
| **DD26S** | CDSView dependencies |
| **DD27S** | CDSView names mapping |
| **DDHEADANNO** | CDSView header annotations |

### Tables

| Table name | Description |
|---|---|
| **DD02L** | Tables |
| **DD02T** | Table texts |
| **DD05S** | Table foreign key conditions |
| **DD08L** | Table foreign keys |
| **DD08T** | Table foreign keys texts	|

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
