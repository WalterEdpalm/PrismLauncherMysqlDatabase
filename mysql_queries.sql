"Stored procedure that finds compatible mods with ModLdrID"
DELIMITER //
CREATE procedure ModCompatibilityCheck(IN Instance_p Varchar(20))
BEGIN
	SELECT ModID,ModName FROM Mods 
    INNER JOIN MCInstance ON 
    Mods.ModLdrID=MCInstance.ModLdrID WHERE MCInstance.InstanceID = Instance_p;
END//
DELIMITER ;

"Stored procedure that adds mod to ModList after checking if they are compatible, else return error"
DELIMITER //
CREATE procedure InsertMod(IN Instance_p Varchar(20),IN Mod_p Varchar(20))
BEGIN
    DECLARE InstanceModLdrID varchar(20);
    DECLARE ModModLdrID varchar(20);
    
	SELECT ModLdrID INTO InstanceModLdrID FROM MCInstance WHERE Instance_p=InstanceID; 
	SELECT ModLdrID INTO ModModLdrID FROM Mods WHERE Mod_p=ModID;
    IF (InstanceModLdrID = ModModLdrID)
        THEN INSERT INTO ModList (InstanceID,ModID) Values (Instance_p,Mod_p);
    ELSE 
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'None Matching ModLdrID error';
	END IF;
END//
DELIMITER ;


"Stored procedure that shows Mods referenced to in ModList in MCInstance"
DELIMITER //
CREATE procedure ShowModsInInstance(IN InstancePK Varchar(20))
BEGIN
    SELECT Mods.ModID,Mods.Modname 
    FROM Mods
    INNER JOIN ModList
    ON ModList.ModID = Mods.ModID WHERE ModList.InstanceID = InstancePK;  
END//
DELIMITER ;



"Function that calculates and returns value of new difficulty" 
DELIMITER //
CREATE FUNCTION DifficultyCalc(InstancePK MEDIUMINT)
RETURNS INT DETERMINISTIC
BEGIN
    DECLARE DifficultySum INT;
    SELECT SUM(Mods.Difficulty) 
    INTO DifficultySum 
    FROM Mods 
    INNER JOIN MCInstance ON Mods.ModLdrID=MCInstance.ModLdrID 
    WHERE MCInstance.InstanceID = InstancePK;
    RETURN DifficultySum;
END//
DELIMITER ;

"Stored procedure that uppdates difficulty on updated MCInstance"
DELIMITER //
CREATE PROCEDURE DifficultyUpdater(IN InstancePK MEDIUMINT)
BEGIN
    DECLARE DifficultySum MEDIUMINT;
    SET DifficultySum = DifficultyCalc(InstancePK);
	UPDATE MCInstance 
    SET Difficulty = DifficultySum 
    WHERE MCInstance.InstanceID = InstancePK;
END//
DELIMITER ;


"Trigger that removes all references in ModList from the removed mod in Mods"
DELIMITER //
CREATE TRIGGER AfterModDeletion
BEFORE DELETE ON Mods FOR EACH ROW
Begin
    DELETE FROM ModList WHERE ModList.ModID = OLD.ModID;
END//
DELIMITER ;

"Trigger that removes all referencing to mod loaders in MCInstance and Mods"
DELIMITER //
CREATE TRIGGER AfterModLdrDeletion
BEFORE DELETE ON ModLoader FOR EACH ROW
Begin
    DELETE FROM Mods WHERE Mods.ModLdrID = OLD.ModLdrID;
    DELETE FROM MCInstance WHERE MCInstance.ModLdrID = OLD.ModLdrID;
END//
DELIMITER ;

"Trigger that removes any Owner thats referensing a deleted MCInstance"
DELIMITER //
CREATE TRIGGER AfterInstanceDeletion
BEFORE DELETE ON MCInstance FOR EACH ROW
Begin
    DELETE FROM Owner WHERE Owner.InstanceID = OLD.InstanceID;
END//
DELIMITER ;

"Stored procedure that removes specified mod from specified instance"
DELIMITER //
CREATE procedure RemoveModFromInstance(IN InstancePK Varchar(20),IN ModPK Varchar(20))
BEGIN
    DELETE FROM ModList WHERE ModList.InstanceID = InstancePK AND ModList.ModID = ModPK;
END//
DELIMITER ;


"Stored procedures that removes mod from db, see triggers for consequences"
DELIMITER //
CREATE procedure RemoveModFromDB(IN ModPK Varchar(20))
BEGIN
    DELETE FROM Mods WHERE Mods.ModID = ModPK;
END//
DELIMITER ;

"Stored procedure that removes a instance of Owning from Owner table"
DELIMITER //
CREATE procedure RemoveOwnerFromDB(IN OwnPK Varchar(20))
BEGIN
    DELETE FROM Owner WHERE Owner.OwnID = OwnPK;
END//
DELIMITER ;

"Stored procedure that removes instance from MCInstance table, see triggers for consequences"
DELIMITER //
CREATE procedure RemoveInstanceFromDB(IN InstancePK Varchar(20))
BEGIN
    DELETE FROM MCInstance WHERE MCInstance.InstanceID = InstancePK;
END//
DELIMITER ;

"Stored procedure that removes mod loader from ModLoader Table"
DELIMITER //
CREATE procedure RemoveModLoaderFromDB(IN ModLdrPK Varchar(20))
BEGIN
    DELETE FROM ModLoader WHERE ModLoader.ModLdrID = ModLdrPK;
END//
DELIMITER ;

"Stored Procedure that shows shared instances between owners"
DELIMITER //
CREATE procedure ShowSharedInstances()
BEGIN
    SELECT InstanceID, GROUP_CONCAT(Username ORDER BY Username) AS Username FROM Owner 
    GROUP BY InstanceID HAVING COUNT(Owner.InstanceID) >= 2;
END//
DELIMITER ;

"Stored procedure that shows all instances a inputted user owns"
DELIMITER //
CREATE procedure ShowMyInstances(IN Uname Varchar(50))
BEGIN
    SELECT * FROM Owner
    INNER JOIN MCInstance ON MCInstance.InstanceID = Owner.InstanceID
    WHERE Owner.Username = Uname;
END//
DELIMITER ;
