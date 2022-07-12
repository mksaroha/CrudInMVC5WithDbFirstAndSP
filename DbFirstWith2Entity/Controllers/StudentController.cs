using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using DbFirstWith2Entity.Models;

namespace DbFirstWith2Entity.Controllers
{
    public class StudentController : Controller
    {
        DbFirstDatabaseEntities context = new DbFirstDatabaseEntities();
        // GET: Employee
        public ActionResult Index()
        {
            //List<UDP_GetAllEmployee_Result> allEmployee = context.UDP_GetAllEmployee().ToList(); 
            //return View(allEmployee);

            //u can delete that property in complex type that u don't want to return like here two propery have creating 
            //for courseId but i dont' want return CourseId1 becuase it will give error in creating view so i delete it in complext types 

            //List<UDP_GetAllEmployees_Result> allEmployees = context.UDP_GetAllEmployees().ToList();
            //return View(allEmployees);

            
            //List<UDP_GetStudents_Result> allstudents = context.UDP_GetStudents().ToList();
            //u dont to write it will need in repository 
            var allStudent = context.UDP_GetStudents().ToList();
            return View(allStudent);

            // u can also do this while creating procedure 
        }

        public ActionResult Details(int id)
        {
            UDP_GetStudent_Result student = context.UDP_GetStudent(id).FirstOrDefault();
            return View(student);
        }

        public ActionResult AddStudent()
        {
            //ViewBag.ListCourse = context.UDP_GetCourse().ToList();
            //u can not do this beacuse ur Add view is entity type so u need to convert  UDP_GetCourse() to Entity type
            ViewBag.ListCourse = context.GetAllCourse().ToList(); 
            return View();
        }

        [HttpPost]
        public ActionResult AddStudent(string name,string city,int courseid)
        {
            if(!ModelState.IsValid)
            {
                return View();
            }
            
            else
            {
                var result = context.UDP_AddStudent(name, city, courseid);
                if (result>0)
                {
                    return RedirectToAction("Index");
                }
                else
                {
                    return View();
                }                
            }
        }

        public ActionResult Edit(int id)
        {
            ViewBag.ListCourse = context.GetAllCourse().ToList();
            var student = context.UDP_GetStudent(id).FirstOrDefault();
            var studentdata = new Student
            {
                Id=student.Id,
                Name=student.Name,
                City=student.City,
                //CourseId=student.CourseId
            };
            return View(studentdata);
        }

        [HttpPost]
        public ActionResult Edit(int id,string name, string city, int courseid)
        {
            if (!ModelState.IsValid)
            {
                return View();
            }

            else
            {
                var result = context.UDP_UpdateStudent(id,name, city, courseid);
                if (result > 0)
                {
                    return RedirectToAction("Index");
                }
                else
                {
                    return View();
                }
            }
        }

        public ActionResult Delete(int id)
        {
            context.UDP_DeleteStudent(id);
            return RedirectToAction("Index");
        }

    }
}