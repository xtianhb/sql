"""
python .\main.py --db COURSE --queries .\course\queries1.sql
python .\main.py --db COMPANY --queries .\company\queries1.sql
python .\main.py --db COURSE --pop
"""


import sys
import db
import argparse

SEPARATOR = 40*" -"

def main( ):
    """ main

    """
    
    parser = argparse.ArgumentParser(description='SQL exercises')
    parser.add_argument('--populate', '-p', type=str, default="", help='Populate database')
    parser.add_argument('--queries', '-q', type=str, default="", help='queries file')
    Args =  parser.parse_args()

    print(SEPARATOR)

    print("Welcome to the PostGresSQL database interface")
   
    ConInfo = db.ReadCfg("database.cfg", "database")
    DbCon, DbCur = db.Connect(ConInfo)
    print("Connected to database: {}".format( ConInfo["db"] ) )
    db.Version(DbCur)

    # Populate database
    if Args.populate != "":
        print("Populating with ", Args.populate)
        db.PopulateDb(DbCon, DbCur, Args.populate)
        print("Done.")
    elif Args.queries != "":
        with open(Args.queries, 'r') as Fq:
            while True:
                EoF, Ok, Q = db.Get_Query(Fq)
                if Ok:
                    print(SEPARATOR)
                    print(Q)
                    ColNames, R = db.Query(DbCon, DbCur, Q)
                    db.Display(ColNames, R)
                if EoF:
                    print(SEPARATOR)
                    print("EoF")
                    break

    DbCon.close()

    print(SEPARATOR)

    return


if __name__ == "__main__":
    main()
