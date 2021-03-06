USE [DbFirstDatabase]
GO
/****** Object:  Table [dbo].[Course]    Script Date: 7/12/2022 6:00:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Course](
	[CourseId] [int] IDENTITY(1,1) NOT NULL,
	[CourseName] [nvarchar](50) NULL,
 CONSTRAINT [PK_Course] PRIMARY KEY CLUSTERED 
(
	[CourseId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Student]    Script Date: 7/12/2022 6:00:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Student](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[City] [nvarchar](50) NULL,
	[CourseId] [int] NULL,
 CONSTRAINT [PK_Student] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
ALTER TABLE [dbo].[Student]  WITH CHECK ADD  CONSTRAINT [FK_Student_Course] FOREIGN KEY([CourseId])
REFERENCES [dbo].[Course] ([CourseId])
GO
ALTER TABLE [dbo].[Student] CHECK CONSTRAINT [FK_Student_Course]
GO
/****** Object:  StoredProcedure [dbo].[UDP_AddStudent]    Script Date: 7/12/2022 6:00:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[UDP_AddStudent]
(
@name nvarchar(50),
@city nvarchar(50),
@courseId int
)
as
begin
insert into Student(Name,City,CourseId) values (@name,@city,@courseId)
end
GO
/****** Object:  StoredProcedure [dbo].[UDP_DeleteStudent]    Script Date: 7/12/2022 6:00:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[UDP_DeleteStudent]
@id int
as
begin
delete from Student where Id=@id
end
GO
/****** Object:  StoredProcedure [dbo].[UDP_GetCourse]    Script Date: 7/12/2022 6:00:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[UDP_GetCourse]
as
begin
select * from Course
end
GO
/****** Object:  StoredProcedure [dbo].[UDP_GetStudent]    Script Date: 7/12/2022 6:00:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[UDP_GetStudent]
(
@id int
)
as
begin
select * from Student inner join Course on Student.CourseId=Course.CourseId where Id=@id
end
GO
/****** Object:  StoredProcedure [dbo].[UDP_GetStudents]    Script Date: 7/12/2022 6:00:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[UDP_GetStudents]
as
begin
select Id,Name,City,CourseName from Student inner join Course on Student.CourseId=Course.CourseId
end

GO
/****** Object:  StoredProcedure [dbo].[UDP_UpdateStudent]    Script Date: 7/12/2022 6:00:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[UDP_UpdateStudent]
(
@id int,
@name nvarchar(50),
@city nvarchar(50),
@courseId int
)
as
begin
update Student set Name=@name,City=@city,CourseId=@courseId where Id=@id
end
GO
