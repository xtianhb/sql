"""

"""

import psycopg2
from configparser import ConfigParser


INDT = [5, 10, 10, 25, 12, 12, 5, 8, 5]


def FormatRow(Row):
    """
    """
    fRow = ""
    for i, c in enumerate(Row):
        sc = str(c)
        sc = sc[ 0 : min( len(sc), INDT[i]-2 ) ]
        fRow += sc + " "*(INDT[i]-len(sc))
    return fRow


def Display(ColNames, Recs):
    """
    
    """
    
    
    Nr = len(Recs)
    A = input("There are {} records. Show? (y/n):".format(Nr) )
    if A=='y':
        H=""
        for i, cn in enumerate(ColNames):
            H += ( cn + " "*(INDT[i]-len(cn)) )
        print(H)
        for i,Row in enumerate(Recs):
            R = FormatRow(Row)
            print(R)
            if i>0 and ((i+1)%10)==0:
                C=input("Continue?:")
                if C!="y":
                    break
    return


def ReadCfg(filename='database.cfg', section='connection'):
    """
    
    """
    
    # create a parser
    parser = ConfigParser()
    # read config file
    parser.read(filename)
    # get section
    db = {}
    if parser.has_section(section):
        params = parser.items(section)
        for param in params:
            db[param[0]] = param[1]
    else:
        raise Exception( 'Section {0} not found in the {1} file'.format(section, filename) )
    if db["ps"]=="":
        db["ps"] = input("Password:")
    return db

def Connect(ConInfo):
    """ Connect

    """

    DbCon = psycopg2.connect(host=ConInfo["host"], 
                            port = ConInfo["port"],
                            database = ConInfo["db"], 
                            user = ConInfo["us"], 
                            password = ConInfo["ps"] )
    Cursor = DbCon.cursor()
    return DbCon, Cursor


def Version(Cur):
    """ Version
    
    """

    # execute a statement
    print('PostgreSQL database version:')
    Cur.execute('SELECT version()')
    # display the PostgreSQL database server version
    db_version = Cur.fetchone()
    print(db_version)
    return


def PopulateDb(DbCon, DbCur, SqlScript):
    sqlfile = open(SqlScript, 'r')
    DbCur.execute( sqlfile.read() )
    DbCon.commit()
    sqlfile.close()
    return


def DropTable(DbCur, Table):
    pass


def Query(DbCur, Q):
    """ Query
    
    """
    try:
        DbCur.execute( Q )
        Res = DbCur.fetchall()
    except: 
        print("Error with query:", Q)
        Res = ''
    return Res


def Get_Query(Fq):
    """ Get_Query
    

    """

    Q = ""
    EoF = False
    Ok = False
    while True:
        l = Fq.readline()
        if "--" in l:
            print("Skip -- line")
            continue
        elif l=="":
            print("EoF")
            EoF=True
            break
        else:
            Q += l
            if ";" in Q:
                Ok=True
                break
    return EoF, Ok, Q
