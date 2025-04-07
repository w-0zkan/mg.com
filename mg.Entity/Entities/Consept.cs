using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace mg.Entity.Entities
{
    public class Consept
    {
        public int ConseptId { get; set; }
        public string ConseptName { get; set; }
        public string ImageUrl { get; set; }
        public int CourseCategoryId  { get; set; }
        public virtual CourseCategory CourseCategory { get; set; }
        public decimal Price { get; set; }
        public bool IsShown { get; set; }
        public int? AppUserId { get; set; }

    }
}