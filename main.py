"""

"""


import sys
import db
import argparse


def main( ):
    """ main

    """
    
    parser = argparse.ArgumentParser(description='SQL exercises')
    parser.add_argument('--db', required=True, type=str, help='Which data base? A(ssingments) or C(course)')
    parser.add_argument('--pop', default=False, action="store_true", help='Populate data base')
    Args =  parser.parse_args()

    print("Welcome to the PostGresSQL database interface")

    if Args.db=="C":
        ConInfo = db.ReadCfg("database.cfg", "course_data")
        DbCon, DbCur = db.Connect(ConInfo)
        QueriesFile = 'course_queries.sql'
    elif Args.db=="A":
        ConInfo = db.ReadCfg("database.cfg", "assign_data")
        DbCon, DbCur = db.Connect(ConInfo)
        QueriesFile = 'assign_queries.sql'
    
    print("Connected to {}".format( ConInfo["db"] ) )
    
    db.Version(DbCur)

    # Populate database
    if Args.pop:
        if Args.db == "C":
            # Database exists, Table exists
            print("Populating database course")
            db.PopulateDb(DbCon, DbCur, "course_data.sql")
    
    ColNames = ["Col" for i in range(9) ]

    with open(QueriesFile, 'r') as Fq:
        while True:
            EoF, Ok, Q = db.Get_Query(Fq)
            if Ok:
                print(Q)
                R = db.Query(DbCur, Q)
                db.Display(ColNames, R)
                
            if EoF:
                break

    DbCon.close()

    print("Connection closed")
    
    return


if __name__ == "__main__":
    main()
