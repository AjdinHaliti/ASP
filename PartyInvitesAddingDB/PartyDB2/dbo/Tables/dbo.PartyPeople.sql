﻿CREATE TABLE [dbo].[PartyPeople] (
    [Id]              INT           NOT NULL IDENTITY(10, 10),
    [NickName]        NVARCHAR (50) NULL,
    [FancyMail]       NVARCHAR (50) NULL,
    [FavouriteAnimal] NVARCHAR (50) NULL,
    [AnimalName]      NVARCHAR (50) NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);

