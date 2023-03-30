# Student Directory Two Tables Design Recipe

## 1. Extract nouns from the user stories or specification

```
As a blogger
So I can write interesting stuff
I want to write posts having a title.

As a blogger
So I can write interesting stuff
I want to write posts having a content.

As a blogger
So I can let people comment on interesting stuff
I want to allow comments on my posts.

As a blogger
So I can let people comment on interesting stuff
I want the comments to have a content.

As a blogger
So I can let people comment on interesting stuff
I want the author to include their name in comments.
```

```
Nouns:
posts, title, content, 
comments, content, author_name
```

## 2. Infer the Table Name and Columns
<!-- Put the different nouns in the table. -->

| Record                | Properties          |
| --------------------- | ------------------  |
| post                  | title, content
| comment               | content, author_name

1. Name of the first table (always plural): `posts` 

    Column names: `title`, `content`

2. Name of the second table (always plural): `comments` 

    Column names: `content`, `author_name`

## 3. Decide the column types.

[Here's a full documentation of PostgreSQL data types](https://www.postgresql.org/docs/current/datatype.html).

Most of the time, you'll need either `text`, `int`, `bigint`, `numeric`, or `boolean`.

Remember to **always** have the primary key `id` as a first column. Its type will always be `SERIAL`.

```
# EXAMPLE:

Table: posts
id: SERIAL
title: text
content: text

Table: cohorts
id: SERIAL
content: text
author_name: text
```

## 4. Decide on The Tables Relationship

1. Can one posts have many comments? YES
2. Can one comments have many posts? NO

```
therefore,
post -> one to many -> comment   ,  a post has many comment
comment -> many to one -> post   ,  a comment belongs to a post

therefore, foreign key is on the comment table
```

## 4. Write the SQL.

```sql
-- EXAMPLE
-- file: blog_tables.sql

-- Create the table without the foreign key first.
CREATE TABLE posts (
  id SERIAL PRIMARY KEY,
  title text,
  content text
);

-- Then the table with the foreign key
CREATE TABLE comments (
  id SERIAL PRIMARY KEY,
  content text,
  author_name text,
  post_id int,
  constraint fk_post foreign key(post_id)
    references posts(id)
);

```

## 5. Create the tables.

```bash
psql -h 127.0.0.1 blog < blog_tables.sql
```