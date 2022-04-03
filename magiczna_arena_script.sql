USE [master]
DROP DATABASE IF EXISTS MagicznaArenaDB
GO
/****** Object:  Database [MagicznaArenaDB]    Script Date: 03.04.2022 15:12:35 ******/
CREATE DATABASE [MagicznaArenaDB]
GO
ALTER DATABASE [MagicznaArenaDB] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [MagicznaArenaDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [MagicznaArenaDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [MagicznaArenaDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [MagicznaArenaDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [MagicznaArenaDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [MagicznaArenaDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [MagicznaArenaDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [MagicznaArenaDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [MagicznaArenaDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [MagicznaArenaDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [MagicznaArenaDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [MagicznaArenaDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [MagicznaArenaDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [MagicznaArenaDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [MagicznaArenaDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [MagicznaArenaDB] SET  ENABLE_BROKER 
GO
ALTER DATABASE [MagicznaArenaDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [MagicznaArenaDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [MagicznaArenaDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [MagicznaArenaDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [MagicznaArenaDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [MagicznaArenaDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [MagicznaArenaDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [MagicznaArenaDB] SET RECOVERY FULL 
GO
ALTER DATABASE [MagicznaArenaDB] SET  MULTI_USER 
GO
ALTER DATABASE [MagicznaArenaDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [MagicznaArenaDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [MagicznaArenaDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [MagicznaArenaDB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [MagicznaArenaDB] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [MagicznaArenaDB] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'MagicznaArenaDB', N'ON'
GO
ALTER DATABASE [MagicznaArenaDB] SET QUERY_STORE = OFF
GO
USE [MagicznaArenaDB]
GO
/****** Object:  Table [dbo].[TBL_Historia]    Script Date: 03.04.2022 15:12:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TBL_Historia](
	[IdHistorii] [int] IDENTITY(1,1) NOT NULL,
	[IdUzytkownika] [int] NOT NULL,
	[Wynik] [nvarchar](50) NOT NULL,
	[IdPrzeciwnika] [int] NOT NULL,
 CONSTRAINT [PK_TBL_Historia] PRIMARY KEY CLUSTERED 
(
	[IdHistorii] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TBL_Klasy]    Script Date: 03.04.2022 15:12:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TBL_Klasy](
	[IdKlasy] [int] IDENTITY(1,1) NOT NULL,
	[NazwaKlasa] [nvarchar](50) NOT NULL,
	[PktZycia] [int] NOT NULL,
	[PktAtaku] [int] NOT NULL,
	[PktObrony] [int] NOT NULL,
 CONSTRAINT [PK_TBL_Klasy] PRIMARY KEY CLUSTERED 
(
	[IdKlasy] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TBL_Przeciwnicy]    Script Date: 03.04.2022 15:12:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TBL_Przeciwnicy](
	[IdPrzeciwnika] [int] IDENTITY(1,1) NOT NULL,
	[NazwaPrzeciwnika] [nvarchar](20) NOT NULL,
	[PktZyciaW] [int] NOT NULL,
	[PktAtakuW] [int] NOT NULL,
	[PktObronyW] [int] NOT NULL,
 CONSTRAINT [PK_TBL_Przeciwnicy] PRIMARY KEY CLUSTERED 
(
	[IdPrzeciwnika] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TBL_Statystyk]    Script Date: 03.04.2022 15:12:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TBL_Statystyk](
	[IdStatystyk] [int] IDENTITY(1,1) NOT NULL,
	[Wygrane] [int] NOT NULL,
	[Przegrane] [int] NOT NULL,
	[IdUzytkownika] [int] NOT NULL,
 CONSTRAINT [PK_TBL_Statystyk] PRIMARY KEY CLUSTERED 
(
	[IdStatystyk] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TBL_Uzytkownicy]    Script Date: 03.04.2022 15:12:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TBL_Uzytkownicy](
	[IdUzytkownika] [int] IDENTITY(1,1) NOT NULL,
	[Login] [varchar](10) NOT NULL,
	[Haslo] [varchar](20) NOT NULL,
	[Email] [varchar](20) NOT NULL,
	[IdKlasy] [int] NULL,
	[CzyAdmin] [bit] NULL,
 CONSTRAINT [PK_TBL_Uzytkownicy] PRIMARY KEY CLUSTERED 
(
	[IdUzytkownika] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[TBL_Klasy] ON 
GO
INSERT [dbo].[TBL_Klasy] ([IdKlasy], [NazwaKlasa], [PktZycia], [PktAtaku], [PktObrony]) VALUES (1, N'Mag', 30, 25, 10)
GO
INSERT [dbo].[TBL_Klasy] ([IdKlasy], [NazwaKlasa], [PktZycia], [PktAtaku], [PktObrony]) VALUES (2, N'Wojownik', 50, 10, 25)
GO
INSERT [dbo].[TBL_Klasy] ([IdKlasy], [NazwaKlasa], [PktZycia], [PktAtaku], [PktObrony]) VALUES (3, N'Łotrzyk', 40, 15, 15)
GO
SET IDENTITY_INSERT [dbo].[TBL_Klasy] OFF
GO
SET IDENTITY_INSERT [dbo].[TBL_Przeciwnicy] ON 
GO
INSERT [dbo].[TBL_Przeciwnicy] ([IdPrzeciwnika], [NazwaPrzeciwnika], [PktZyciaW], [PktAtakuW], [PktObronyW]) VALUES (1, N'Ork Przytulas', 60, 3, 20)
GO
INSERT [dbo].[TBL_Przeciwnicy] ([IdPrzeciwnika], [NazwaPrzeciwnika], [PktZyciaW], [PktAtakuW], [PktObronyW]) VALUES (2, N'Szalony Krasnolud', 25, 20, 15)
GO
INSERT [dbo].[TBL_Przeciwnicy] ([IdPrzeciwnika], [NazwaPrzeciwnika], [PktZyciaW], [PktAtakuW], [PktObronyW]) VALUES (3, N'Duszący się Smok', 80, 5, 20)
GO
INSERT [dbo].[TBL_Przeciwnicy] ([IdPrzeciwnika], [NazwaPrzeciwnika], [PktZyciaW], [PktAtakuW], [PktObronyW]) VALUES (4, N'Wilkołak Leszek', 30, 25, 5)
GO
INSERT [dbo].[TBL_Przeciwnicy] ([IdPrzeciwnika], [NazwaPrzeciwnika], [PktZyciaW], [PktAtakuW], [PktObronyW]) VALUES (5, N'Szkielet z nadwagą', 20, 5, 5)
GO
SET IDENTITY_INSERT [dbo].[TBL_Przeciwnicy] OFF
GO
SET IDENTITY_INSERT [dbo].[TBL_Uzytkownicy] ON 
GO
INSERT [dbo].[TBL_Uzytkownicy] ([IdUzytkownika], [Login], [Haslo], [Email], [IdKlasy], [CzyAdmin]) VALUES (1, N'Admin', N'Admin', N'Admin@email.com', NULL, 1)
GO
SET IDENTITY_INSERT [dbo].[TBL_Uzytkownicy] OFF
GO
ALTER TABLE [dbo].[TBL_Historia]  WITH CHECK ADD  CONSTRAINT [FK_TBL_Historia_TBL_Przeciwnicy] FOREIGN KEY([IdPrzeciwnika])
REFERENCES [dbo].[TBL_Przeciwnicy] ([IdPrzeciwnika])
GO
ALTER TABLE [dbo].[TBL_Historia] CHECK CONSTRAINT [FK_TBL_Historia_TBL_Przeciwnicy]
GO
ALTER TABLE [dbo].[TBL_Historia]  WITH CHECK ADD  CONSTRAINT [FK_TBL_Historia_TBL_Uzytkownicy] FOREIGN KEY([IdUzytkownika])
REFERENCES [dbo].[TBL_Uzytkownicy] ([IdUzytkownika])
GO
ALTER TABLE [dbo].[TBL_Historia] CHECK CONSTRAINT [FK_TBL_Historia_TBL_Uzytkownicy]
GO
ALTER TABLE [dbo].[TBL_Statystyk]  WITH CHECK ADD  CONSTRAINT [FK_TBL_Statystyk_TBL_Uzytkownicy1] FOREIGN KEY([IdUzytkownika])
REFERENCES [dbo].[TBL_Uzytkownicy] ([IdUzytkownika])
GO
ALTER TABLE [dbo].[TBL_Statystyk] CHECK CONSTRAINT [FK_TBL_Statystyk_TBL_Uzytkownicy1]
GO
ALTER TABLE [dbo].[TBL_Uzytkownicy]  WITH CHECK ADD  CONSTRAINT [FK_TBL_Uzytkownicy_TBL_Klasy] FOREIGN KEY([IdKlasy])
REFERENCES [dbo].[TBL_Klasy] ([IdKlasy])
GO
ALTER TABLE [dbo].[TBL_Uzytkownicy] CHECK CONSTRAINT [FK_TBL_Uzytkownicy_TBL_Klasy]
GO
USE [master]
GO
ALTER DATABASE [MagicznaArenaDB] SET  READ_WRITE 
GO
