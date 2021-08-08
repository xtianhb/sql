"""
python .\main.py --db COURSE --queries .\course\queries1.sql
python .\main.py --db COMPANY --queries .\company\queries1.sql
python .\main.py --db COURSE --pop
"""


import sys
import db
import argparse


def main( ):
    """ main

    """
    
    parser = argparse.ArgumentParser(description='SQL exercises')
    parser.add_argument('--db', required=True, type=str, help='Which data base? COURSE | COMPANY ')
    parser.add_argument('--pop', default=False, action="store_true", help='Populate data base')
    parser.add_argument('--queries', type=str, help='queries file')
    Args =  parser.parse_args()

    print("Welcome to the PostGresSQL database interface")

    QueriesFile = Args.queries

    if Args.db=="COURSE":
        ConInfo = db.ReadCfg("database.cfg", "course_data")
        DbCon, DbCur = db.Connect(ConInfo)
    elif Args.db=="COMPANY":
        ConInfo = db.ReadCfg("database.cfg", "company_data")
        DbCon, DbCur = db.Connect(ConInfo)
    else:
        print("Select database: COURSE | COMPANY")
        exit(-1)
    
    print("Connected to {}".format( ConInfo["db"] ) )
    
    db.Version(DbCur)

    # Populate database
    if Args.pop:
        if Args.db == "COURSE":
            print("Populating database course")
            db.PopulateDb(DbCon, DbCur, "course/course_data.sql")
        elif Args.db == "COMPANY":
            print("Populating database company")
            db.PopulateDb(DbCon, DbCur, "company/company_data.sql")
    else:
        with open(QueriesFile, 'r') as Fq:
            while True:
                EoF, Ok, Q = db.Get_Query(Fq)
                if Ok:
                    print(Q)
                    ColNames, R = db.Query(DbCur, Q)
                    db.Display(ColNames, R)
                    
                if EoF:
                    break

    DbCon.close()

    print("Connection closed")
    
    return


if __name__ == "__main__":
    main()
