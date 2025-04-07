using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;


namespace mg.Entity.Entities;

public class BlogCatagory
{
    public int BlogCategoryId { get; set; }
    public string Name { get; set; }

    public virtual List <BlogCatagory > Blogs { get; set; }

}