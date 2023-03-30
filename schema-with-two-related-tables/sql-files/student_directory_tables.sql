CREATE TABLE cohorts (
  id SERIAL PRIMARY KEY,
  name text,
  starting_date date
);

CREATE TABLE students (
  id SERIAL PRIMARY KEY,
  title text,
  release_year int,
  cohort_id int,
  constraint fk_cohort foreign key(cohort_id)
    references cohorts(id)
);