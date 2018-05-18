using ITUBIDB.Net.Management;
using ItuNetCore;
using ItuNetDataAccessLayer;
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
        if (!IsPostBack)
        {
            AttemptMethod(BindPage);
        }
    }

    protected void lbFindMac_Click(object sender, EventArgs e)
    {
        AttemptMethod(FindMacAlghrotihm);
    }

    private void FindMacAlghrotihm()
    {
        Dictionary<string, string> ipsWalked = new Dictionary<string, string>();
        bool cont = true;
        string ip = ddlDevice.SelectedValue;
        string mac = tbMacAddress.Text.Trim();
        string oid = "1.3.6.1.2.1.17.4.3.1.2";
        foreach (string item in mac.Split(':'))
        {
            oid += "." + Int64.Parse(item, System.Globalization.NumberStyles.HexNumber);
        }
        while (cont)
        {
            ipsWalked.Add(ip, "Not found in this device");
            FinalAgent fa = new FinalAgent(ip);
            object macBridgeNo = null;
            List<ITUBIDB.Net.Management.MIBS.SnmpMIB2.Interface> vlanStatic = fa.VlanList;
            foreach (var item in vlanStatic)
            {
                if (item.IsAdminUp()) fa.ReconnectWithVlan(item.ifIndex.ToString());
                macBridgeNo = fa.Get(oid);
                if (macBridgeNo != null) break;
            }
            if (macBridgeNo != null)
            {
                object macIfIndexNo = fa.Get("1.3.6.1.2.1.17.1.4.1.2." + macBridgeNo);
                object macIfDescr = fa.Get("1.3.6.1.2.1.31.1.1.1.1." + macIfIndexNo);
                BasicInterfaceInformation intf = fa.GetInterfaceInformation().FirstOrDefault(i => i.IfIndex == Convert.ToInt32(macIfIndexNo.ToString()));
                ipsWalked[ip] = "Found on : " + intf.IfDescription;
                if (intf.IfCdpExist)
                {
                    ip = fa.GetCdpList().FirstOrDefault(i => i.cdpIfIndex == intf.IfIndex).cdpAddress;
                }
                if (ipsWalked.ContainsKey(ip) || !DataProvider.Devices.Any(i => i.IpAddress == ip)) cont = false;
            }
            else
            {
                cont = false;
            }
        }
        gvRes.DataSource = ipsWalked;
        gvRes.DataBind();
    }
    private void BindPage()
    {
        string oid = "1.3.6.1.2.1.17.4.3.1.2";
        FinalAgent fa = new FinalAgent("10.0.100.100");
        List<Tuple<string, string>> macList = new List<Tuple<string, string>>();
        SnmpItemList siList = new SnmpItemList();
        string mac = "";
        List<ITUBIDB.Net.Management.MIBS.SnmpMIB2.Interface> vlanStatic = fa.VlanList;
        foreach (var vlanItem in vlanStatic)
        {
            if (vlanItem.IsAdminUp()) fa.ReconnectWithVlan(vlanItem.ifIndex.ToString());
            siList = fa.GetWalkResultSet(oid);
            foreach (var item in siList)
            {
                mac = "";
                string.Join(".", item.Oid).Replace(oid + ".", "").Split('.').ToList().ForEach(i => mac += (Convert.ToInt32(i.Trim()).ToString("X").Count() == 2 ? Convert.ToInt32(i.Trim()).ToString("X") : "0" + Convert.ToInt32(i.Trim()).ToString("X")) + ":");
                macList.Add(new Tuple<string, string>(mac.Remove(mac.Length - 1), item.Value.ToString()));
            }
        }
        gv.DataSource = macList;
        gv.DataBind();


        List<Device> dList = DataProvider.Devices.OrderBy(i => i.DeviceId).ToList();
        List<DropDownData> ddlData = new List<DropDownData>();
        dList.ForEach(i => ddlData.Add(new DropDownData() { Display = i.IpAddress + " - " + i.HostName, Ip = i.IpAddress }));
        ddlDevice.DataSource = ddlData;
        ddlDevice.DataBind();
    }
    private struct DropDownData
    {
        public string Display { get; set; }
        public string Ip { get; set; }
    }

}