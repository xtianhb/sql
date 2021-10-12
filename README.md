## Master SQL for Data Science

Took this course from Udemy to formalize some basic SQL skills for Data Science.

### Requirements

* Python 3, with library psycopg2.
* postgreSQL server <https://www.postgresql.org/>

### Running

1. Clone this repo.
2. Download, install, and configure your postgreSQL database server. Ajust `database.cfg` to your server config.
3. Go to the root of this repo.
4. Populate de database with the different tables:vx
```
python main.py -p company/data.sql
python main.py -p course/data.sql
python main.py -p course/fruit.sql
```
5. Test the queries from the files and check the results:
```
python main.py -q company/queries1.sql
```