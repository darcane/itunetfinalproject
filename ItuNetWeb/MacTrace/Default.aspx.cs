using ItuNetCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class MacTrace_Default : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void lbFindMac_Click(object sender, EventArgs e)
    {
        FinalAgent fa = new FinalAgent("10.0.100.100");

        string oid = "1.3.6.1.2.1.17.4.3.1.2";
        string mac = tbMacAddress.Text.Trim();
        foreach (string item in mac.Split(':'))
        {
            oid += "." + Int64.Parse(item,System.Globalization.NumberStyles.HexNumber);
        }
        object macBridgeNo = null;
        foreach (var item in fa.VlanList)
        {
            if(item.IsAdminUp()) fa.ReconnectWithVlan(item.ifIndex.ToString());
            macBridgeNo = fa.Get(oid);
            if (macBridgeNo != null) break;
        }
        object macIfIndexNo = fa.Get("1.3.6.1.2.1.17.1.4.1.2." + macBridgeNo);
        object macIfDescr = fa.Get("1.3.6.1.2.1.31.1.1.1.1." + macIfIndexNo);
        if (fa.GetInterfaceInformation().FirstOrDefault(i => i.IfIndex == Convert.ToInt32(macIfIndexNo.ToString())).IfCdpExist)
        {
            lblTest.Text = "alt switchden geldi : " + macIfDescr.ToString();
        }
        lblTest.Text = macIfDescr.ToString();

    }
}