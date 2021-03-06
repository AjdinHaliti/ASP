﻿/*
Deployment script for PartyDB2

This code was generated by a tool.
Changes to this file may cause incorrect behavior and will be lost if
the code is regenerated.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "PartyDB2"
:setvar DefaultFilePrefix "PartyDB2"
:setvar DefaultDataPath "C:\Users\gropc\AppData\Local\Microsoft\Microsoft SQL Server Local DB\Instances\MSSQLLocalDB"
:setvar DefaultLogPath "C:\Users\gropc\AppData\Local\Microsoft\Microsoft SQL Server Local DB\Instances\MSSQLLocalDB"

GO
:on error exit
GO
/*
Detect SQLCMD mode and disable script execution if SQLCMD mode is not supported.
To re-enable the script after enabling SQLCMD mode, execute the following:
SET NOEXEC OFF; 
*/
:setvar __IsSqlCmdEnabled "True"
GO
IF N'$(__IsSqlCmdEnabled)' NOT LIKE N'True'
    BEGIN
        PRINT N'SQLCMD mode must be enabled to successfully execute this script.';
        SET NOEXEC ON;
    END


GO
USE [$(DatabaseName)];


GO
PRINT N'Starting rebuilding table [dbo].[PartyPeople]...';


GO
BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

SET XACT_ABORT ON;

CREATE TABLE [dbo].[tmp_ms_xx_PartyPeople] (
    [Id]              INT           IDENTITY (1, 1) NOT NULL,
    [NickName]        NVARCHAR (50) NULL,
    [FancyMail]       NVARCHAR (50) NULL,
    [FavouriteAnimal] NVARCHAR (50) NULL,
    [AnimalName]      NVARCHAR (50) NULL,
    CONSTRAINT [tmp_ms_xx_constraint_PK_PartyPeople1] PRIMARY KEY CLUSTERED ([Id] ASC)
);

IF EXISTS (SELECT TOP 1 1 
           FROM   [dbo].[PartyPeople])
    BEGIN
        SET IDENTITY_INSERT [dbo].[tmp_ms_xx_PartyPeople] ON;
        INSERT INTO [dbo].[tmp_ms_xx_PartyPeople] ([Id], [NickName], [FancyMail], [FavouriteAnimal], [AnimalName])
        SELECT   [Id],
                 [NickName],
                 [FancyMail],
                 [FavouriteAnimal],
                 [AnimalName]
        FROM     [dbo].[PartyPeople]
        ORDER BY [Id] ASC;
        SET IDENTITY_INSERT [dbo].[tmp_ms_xx_PartyPeople] OFF;
    END

DROP TABLE [dbo].[PartyPeople];

EXECUTE sp_rename N'[dbo].[tmp_ms_xx_PartyPeople]', N'PartyPeople';

EXECUTE sp_rename N'[dbo].[tmp_ms_xx_constraint_PK_PartyPeople1]', N'PK_PartyPeople', N'OBJECT';

COMMIT TRANSACTION;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;


GO
PRINT N'Update complete.';


GO
