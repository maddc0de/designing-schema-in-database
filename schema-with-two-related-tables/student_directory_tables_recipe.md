# Student Directory Two Tables Design Recipe

## 1. Extract nouns from the user stories or specification

```
As a coach
So I can get to know all students
I want to see a list of students' names.

As a coach
So I can get to know all students
I want to see a list of cohorts' names.

As a coach
So I can get to know all students
I want to see a list of cohorts' starting dates.

As a coach
So I can get to know all students
I want to see a list of students' cohorts.
```

```
Nouns:
students, name
cohorts, name, starting_date
```

cohort -> one to many -> student

## 2. Infer the Table Name and Columns
<!-- Put the different nouns in the table. -->

| Record                | Properties          |
| --------------------- | ------------------  |
| student               | name
| cohort                | name, starting_date

1. Name of the first table (always plural): `students` 

    Column names: `name`

2. Name of the second table (always plural): `cohorts` 

    Column names: `name`, `starting_date`

## 3. Decide the column types.

[Here's a full documentation of PostgreSQL data types](https://www.postgresql.org/docs/current/datatype.html).

Most of the time, you'll need either `text`, `int`, `bigint`, `numeric`, or `boolean`.

Remember to **always** have the primary key `id` as a first column. Its type will always be `SERIAL`.

```
# EXAMPLE:

Table: students
id: SERIAL
name: text

Table: cohorts
id: SERIAL
name: text
starting_date: date
```

## 4. Decide on The Tables Relationship

Most of the time, you'll be using a **one-to-many** relationship, and will need a **foreign key** on one of the two tables.
To decide on which one, answer these two questions:

1. Can one students have many cohorts? NO
2. Can one cohorts have many students? YES

```
therefore,
student -> many to one -> cohort   ,  a student belongs to a cohort
cohort -> one to many -> student   ,  a cohort has many students

therefore, foreign key is on the students table
```

## 4. Write the SQL.

```sql
-- EXAMPLE
-- file: student_directory_tables.sql

-- Create the table without the foreign key first.
CREATE TABLE cohorts (
  id SERIAL PRIMARY KEY,
  name text,
  starting_date date
);

-- Then the table with the foreign key
CREATE TABLE students (
  id SERIAL PRIMARY KEY,
  title text,
  release_year int,
  cohort_id int,
  constraint fk_cohort foreign key(cohort_id)
    references cohorts(id)
);

```

## 5. Create the tables.

```bash
psql -h 127.0.0.1 student_directory_2 < student_directory_tables.sql
```