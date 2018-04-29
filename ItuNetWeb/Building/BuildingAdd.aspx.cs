using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Building_BuildingAdd : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void btnAddBuilding_Click(object sender, EventArgs e)
    {
        DataProvider.Buildings.Add(new ItuNetDataAccessLayer.Building()
        {
            BuildingName = tbBuildingName.Text.Trim(),
            BuildingKey = tbBuildingName.Text.Trim().ToLower().Replace(" ","-")
        });
        DataProvider.SaveChanges();
        Response.Redirect("Default.aspx");
    }
}