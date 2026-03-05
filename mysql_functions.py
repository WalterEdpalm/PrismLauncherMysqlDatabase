
def man_create_modldr(mycursor,mydb):
    val2 = input("Input Version: ")
    val3 = input("Input Mod Loader (Forge or Fabric): ")
    values = (val2, val3)
    sql = "INSERT INTO ModLoader (Version, Modloader) VALUES (%s, %s)"
    mycursor.execute(sql, values)
    mydb.commit()
    return

def man_create_instance(mycursor,mydb):
    val2 = input("Input Instance Name: ")
    val3 = input("Input Playtime in hours (input 0 if new): ")
    val4 = input("Input Mod Loader ID: ")
    val5 = 0
    values = (val2, val3, val4, val5)
    sql = "INSERT INTO MCInstance (InstanceName, Playtime, ModLdrID, Difficulty) VALUES (%s, %s, %s, %s)"
    mycursor.execute(sql, values)
    mydb.commit()
    return

def man_create_mod(mycursor,mydb):
    val2 = input("Input Mod Name: ")
    val3 = input("Input Difficulty (0-5): ")
    val4 = input("Input Mod Loader ID: ")
    values = (val2, val3, val4)
    sql = "INSERT INTO Mods (ModName, Difficulty, ModLdrID) VALUES (%s, %s, %s)"
    mycursor.execute(sql, values)
    mydb.commit()
    return

def man_create_owner(mycursor,mydb):
    val2 = input("Input User Name: ")
    val3 = input("Input Instance ID: ")
    values = (val2, val3)
    sql = "INSERT INTO Owner (Username, InstanceID) VALUES (%s, %s)"
    mycursor.execute(sql, values)
    mydb.commit()
    return

def print_db(mycursor,mydb,option):
    sql = "SELECT * FROM " + option 
    mycursor.execute(sql)
    myresult = mycursor.fetchall()

    for x in myresult:
        print(x)
    
    return
