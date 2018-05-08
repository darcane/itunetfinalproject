using ITUBIDB.Net.Management;
using ItuNetCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class SnmpTest : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            
        }
    }

    protected void lbGet_Click(object sender, EventArgs e)
    {
        string oid = tbOid.Text.Trim();//selam
        FinalAgent fa = new FinalAgent("10.0.100.100");
        SnmpItemList siList = fa.GetWalkResultSet(oid);
        Dictionary<string, string> listToBind = new Dictionary<string, string>();
        foreach (SnmpItem item in siList)
        {
            string mac = "";
            string.Join(".", item.Oid).Replace(oid+".", "").Split('.').ToList().ForEach(i => mac += (Convert.ToInt32(i.Trim()).ToString("X"))+":");
            listToBind.Add(string.Join(".",item.Oid),mac.Remove(mac.Length-1));
        }
        gv.DataSource = listToBind;
        gv.DataBind();
    }
}