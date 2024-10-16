# SAP S/4 Metadata Extraction

## Motivation

Azure data engineers usually don't have much experience working with SAP data. Moreover, they are often not granted access to the source SAP ERP for exploration. Based on our experience from previous projects, we selected a set relevant SAP tables and Azure Data Factory extraction pipelines to bring the most important SAP ERP object metadata to Azure Data Lake, thereby helping data engineers explore SAP data sources, specific fields, and their relationships.

In the first stage, the base SAP tables are ingested into Azure Blob storage. From here, they can be further process by a Data platform of choice to provide an exhaustive data model representing all relationships between SAP objects of a business value, which are to be extracted.

## Pre-built Azure DataFactory (ADF) Pipelines

We provide you with a pre-built configuration to set up the metadata extraction pipelines in your ADF quickly.

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
