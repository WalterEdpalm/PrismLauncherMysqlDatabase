from mysql_functions import *

import mysql.connector

mydb = mysql.connector.connect(
    host="localhost",
    user="root",
    password="example",
    database="sql_db_1"
)
mycursor = mydb.cursor()
choices2 ="""Options:
1: Remove Mod from Instance.
2: Remove Mod from Modpool (And all Instances).
3: Remove Ownership of profile.
4: Remove Instance.
5: Remove ModLoaders (And everything depending on it).
back: type 'back' to return"""
choices1 = """Options:
1: Find compatible mods with Minecraft Mod Instance.
2: Add mod to Instance from mod pool.
3: Add mod to mod pool.
4: Create Mod Loader.
5: Create Instance
6: Give Ownership to instance
back: type 'back' to return"""
tables = """Tables:
Owner: All owners
MCInstance: All instances
ModLoader: All modloaders
Mods: All mods
ModList: What mods a instance contains. Needs PK
back: type 'back' to return"""
choices0="""Options:
1: Look at database.
2: Add content to database.
3: Remove from database.
4: Show Shared Profiles.
5: Show One Users Profiles.
exit: Close program """

def look_at_db(mycursor,mydb):
    print(tables)
    while True:
        option = input("What table would you like to look at? ")
        if option == "Mods":
            print_db(mycursor,mydb,option)
        if option == "Owner":
            print_db(mycursor,mydb,option)
        if option == "MCInstance":
            print_db(mycursor,mydb,option)    
        if option == "ModList":
            instance_pk =int(input("Input Instance PK: "))
            mycursor.callproc("ShowModsInInstance",[instance_pk])
            myresult = mycursor.stored_results()
            for x in myresult:
                for row in x.fetchall():
                    print(row)
        if option == "ModLoader":
            print_db(mycursor,mydb,option)
        if option == "back":
            return

def add_content(mycursor,mydb):
    while True:
        print(choices1)
        option = input("What would you like to do? ")    
        if option == "1":
            sql = "SELECT InstanceID, InstanceName FROM MCInstance" 
            mycursor.execute(sql)
            myresult = mycursor.fetchall()
            for x in myresult:
                print(x)

            instance_pk =int(input("Input Instance PK: "))
            mycursor.callproc("ModCompatibilityCheck",[instance_pk])
            myresult = mycursor.stored_results()
            for x in myresult:
                for row in x.fetchall():
                    print(row)
        if option == "2":
            instance_pk = int(input("Input instance PK: "))
            mod_pk = int(input("Input mod PK: "))
            mycursor.callproc("InsertMod",[instance_pk,mod_pk])
            mydb.commit()
            mycursor.callproc("DifficultyUpdater",[instance_pk])
            
        if option == "3":
            man_create_mod(mycursor,mydb)

        if option == "4":
            man_create_modldr(mycursor,mydb)
        
        if option == "5":
            man_create_instance(mycursor,mydb)
            
        if option == "6":
            man_create_owner(mycursor,mydb)

        if option == "back":
            return
        mydb.commit()

def remove_content(mycursor,mydb):
    while True:
        print(choices2)
        option = input("What would you like to do? ")
        if option == "1":
            instance_pk = int(input("Input Instance PK: "))
            mod_pk = int(input("Input Mod PK: "))
            mycursor.callproc("RemoveModFromInstance",[instance_pk,mod_pk])
        if option == "2":
            mod_pk = int(input("Input Mod PK: "))
            mycursor.callproc("RemoveModFromDB",[mod_pk])
        if option == "3":
            own_pk = int(input("Input Owner PK: "))
            mycursor.callproc("RemoveOwnerFromDB",[own_pk])
        if option == "4":
            instance_pk = int(input("Input Instance PK: "))
            mycursor.callproc("RemoveInstanceFromDB",[instance_pk])
        if option == "5":
            mod_loader_pk = int(input("Input Mod Loader PK: "))
            mycursor.callproc("RemoveModLoaderFromDB",[mod_loader_pk])     
        if option == "back":
            return
        mydb.commit()


running = True

while running:
    print(choices0)
    option = input("What would you like to do? ")
    if option == "1":
        look_at_db(mycursor,mydb)
    if option == "2":
        add_content(mycursor,mydb)
    if option == "3":
        remove_content(mycursor,mydb)
    if option == "4":
        mycursor.callproc("ShowSharedInstances")
        myresult = mycursor.stored_results()
        for x in myresult:
            for row in x.fetchall():
                print(row)
    if option == "5":
        option = input("Which User? ")
        mycursor.callproc("ShowMyInstances",[option])
        myresult = mycursor.stored_results()
        for x in myresult:
            for row in x.fetchall():
                print(row)        
    if option == "exit":
        running = False
        
    
