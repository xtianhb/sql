"""

"""

import sys
import psycopg2
from configparser import ConfigParser


def FormatRow(Cn, Row, COLSP):
    """
    """
    fRow = ""
    for i, c in enumerate(Row):
        sc = str(c)
        lcn = len(Cn[i])
        sc = sc[ 0 : min(len(sc), lcn+COLSP-2) ] 
        fRow += sc + " "*(COLSP+lcn-len(sc))
    return fRow


def Display(ColName, Recs):
    """
    
    """
    NCols = len( ColName )
    if NCols == 0:
        return

    Nr = len(Recs)
    A = 'y'
    if Nr>50:
        A = input("There are {} records. Show? (y/n):".format(Nr) )
    if A.lower()=='y':
        H=""        
        COLSP = int( 80 /(NCols+1) )
        for i, cn in enumerate(ColName):
            H += ( cn + COLSP*" " )  
        print(H)
        for i,Row in enumerate(Recs):
            R = FormatRow(ColName, Row, COLSP)
            print(R)
            #if i>0 and ((i+1)%10)==0:
            #    C=input("Continue?:")
            #    if C!="y":
            #        break
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
    Cur.execute('SELECT version()')
    # display the PostgreSQL database server version
    db_version = Cur.fetchone()
    print("PostgreSQL version: " + db_version[0] )
    return


def PopulateDb(DbCon, DbCur, SqlScript):
    try:
        sqlfile = open(SqlScript, 'r')
        DbCur.execute( sqlfile.read() )
        DbCon.commit()
        sqlfile.close()
    except psycopg2.errors.DuplicateTable as SErr:
        print("ERR:", SErr)
    except:
        print("Error populating database")
    return


def DropTable(DbCur, Table):
    pass


def Query(DbCon, DbCur, Q):
    """ Query
    
    """
    ColNames = []
    try:
        Res=""
        DbCur.execute(Q)
        Res = DbCur.fetchall()
        ColNames = [Desc[0] for Desc in DbCur.description]
    except Exception as Err:
        err_type, err_obj, traceback = sys.exc_info()
        line_num = traceback.tb_lineno
        print ("psycopg2 ERROR:" + str(Err) + "Line number:", line_num)
        print ("psycopg2 traceback:", traceback, "-- type:", err_type)
        print ("extensions.Diagnostics:", Err.diag)
        print ("pgerror:", Err.pgerror)
        print ("pgcode:", Err.pgcode, "\n")
        DbCon.rollback()
    return ColNames, Res


def Get_Query(Fq):
    """ Get_Query
    

    """

    Q = ""
    EoF = False
    Ok = False
    while True:
        l = Fq.readline()
        if ("--" in l) :
            # skip line
            continue
        elif l=="":
            EoF=True
            break
        else:
            Q += l
            if ";" in Q:
                Ok = True
                break

    return EoF, Ok, Q
