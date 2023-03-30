# DATABASES: Designing a Schema

----

## Introduction

a Schema in a Database is like a blueprint or a plan that outlines the structure and organisation of the data in the database. It defines the tables, columnes and relationships between them, as well as any constraints that apply to the data.

It serves as a framework for storing and accessing the data.

----

## Objective

* To learn to design and create a schema with one table
* To learn to design and create a scheme with two tables and a foreign key: Using a Relational Database type, **one-to-many**, relationship between two tables.

----

## Other information

>Configuring "Cascade" Deletion
>When a record is deleted (e.g when a row in artists is deleted), we can configure >the database to automatically remove related records referencing it (e.g delete all >related albums), so there are no "orphans" records - this is done using the on >delete cascade SQL option, when creating the table:
>
>```sql
>-- This snippet is taken from the Two Tables Schema Design Recipe document
>constraint fk_artist foreign key(artist_id)
>    references artists(id) 
>   on delete cascade 
>```
