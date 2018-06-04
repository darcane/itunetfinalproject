using ITUBIDB.Net.Management.MIBS.Enterprise.Cisco.Mgmt;
using ItuNetCore;
using ItuNetDataAccessLayer;
using QRCoder;
using System;
using System.Collections.Generic;
using System.Drawing;
using System.Drawing.Imaging;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Device_Details : BasePage
{
    public SwitchBasicInformation SwitchInfo
    {
        get { if (ViewState["SwitchInfo"] == null) return new SwitchBasicInformation(); else return ViewState["SwitchInfo"] as SwitchBasicInformation; }
        set { ViewState["SwitchInfo"] = value; }
    }
    public List<BasicInterfaceInformation> InterfaceInfo
    {
        get { if (ViewState["InterfaceInfo"] == null) return new List<BasicInterfaceInformation>(); else return ViewState["InterfaceInfo"] as List<BasicInterfaceInformation>; }
        set { ViewState["InterfaceInfo"] = value; }
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            BindPage();
        }
    }

    private void BindPage()
    {
        string key = Request.QueryString["key"];
        //string ip = Request.QueryString["ip"];
        Device d = DataProvider.Devices.FirstOrDefault(i => i.DeviceKey == key);
        if (d != default(Device))
        {
            FinalAgent fa = new FinalAgent(d.IpAddress);
            SwitchInfo = fa.GetBasicInformation();
            InterfaceInfo = fa.GetInterfaceInformation();
            ddlBuilding.DataSource = DataProvider.Buildings.ToList();
            ddlBuilding.DataBind();
            SwitchBasicInformation sb = new SwitchBasicInformation() { DeviceKey = d.DeviceKey, DeviceType = d.DeviceType.DeviceTypeName, HostName = d.HostName, IPAddress = d.IpAddress };
            //if (SwitchInfo.Equals(sb)) { string status = "değisiklik var"; }
            SwitchInfo.DeviceKey = d.DeviceKey;
            ddlBuilding.SelectedValue = d.BuildingId.ToString();
            List<BasicInterfaceInformation> listBif = new List<BasicInterfaceInformation>();
            d.InterfaceInformations.ToList().ForEach(i => listBif.Add(new BasicInterfaceInformation()
            {
                IfCdpExist = i.HasCdpInfo,
                IfConnected = i.IsConnected,
                IfDescription = i.InterfaceName,
                IfIndex = i.InterfaceIndex,
                IfNumber = i.PortNumber,
                IfStat = i.IsOpen
            }));
            foreach (BasicInterfaceInformation item in InterfaceInfo)
            {
                BasicInterfaceInformation bif = listBif.FirstOrDefault(i => i.IfIndex == item.IfIndex);
                if (bif == default(BasicInterfaceInformation) ||
                    item.IfCdpExist != bif.IfCdpExist ||
                    item.IfConnected != bif.IfConnected ||
                    item.IfDescription != bif.IfDescription ||
                    item.IfIndex != bif.IfIndex ||
                    item.IfNumber != bif.IfNumber ||
                    item.IfStat != bif.IfStat)
                    item.IsUpdated = true;
            }
            pnlDeviceExist.Visible = true;
            #region CdpBind
            Cdp cdp = new Cdp(fa.Agent);
            CdpResultSet cdpResult = cdp.GetCdpList();
            List<CdpItem> cdpLi = cdpResult.Values.SelectMany(i => i.Values.ToList()).ToList();
            rpCdp.DataSource = cdpLi;
            rpCdp.DataBind();
            foreach (RepeaterItem item in rpCdp.Items)
            {
                Label lblAlias = item.FindControl("lblCdpConnectedPort") as Label;
                HiddenField hdnIfIndex = item.FindControl("hdnCdpIfIndex") as HiddenField;
                lblAlias.Text = Convert.ToString(fa.Get(String.Concat("1.3.6.1.2.1.2.2.1.2.", hdnIfIndex.Value))).Replace("FastEthernet", "Fa ").Replace("GigabitEthernet", "Gi ");
            }
            #endregion
        }
        else
        {
            throw new Exception("Device not found");
        }
        tbHostName.Text = SwitchInfo.HostName;
        tbDeviceKey.Text = SwitchInfo.DeviceKey;
        tbDeviceType.Text = SwitchInfo.DeviceType;
        QRCodeGenerate(SwitchInfo.DeviceKey);
        rpInterfaces.DataSource = InterfaceInfo;
        rpInterfaces.DataBind();
    }

    private void QRCodeGenerate(string deviceKey)
    {
        QRCodeGenerator qrGenerator = new QRCodeGenerator();
        string href = "http://local.itunet/Device/Details.aspx?key=" + deviceKey;
        QRCodeData qrCodeData = qrGenerator.CreateQrCode(href, QRCodeGenerator.ECCLevel.L);
        QRCode qrCode = new QRCode(qrCodeData);
        Bitmap qrCodeImage = qrCode.GetGraphic(20, Color.Black, Color.White, false);
        using (MemoryStream ms = new MemoryStream())
        {
            qrCodeImage.Save(ms, ImageFormat.Gif);
            var base64Data = Convert.ToBase64String(ms.ToArray());
            imgQR.Src = "data:image/gif;base64," + base64Data;
            qrHref.HRef = href;
            qrHref.InnerHtml = href;
        }
    }

    protected void lbUpdateDevice_Click(object sender, EventArgs e)
    {
        string key = Request.QueryString["key"];
        Device toUpdate = DataProvider.Devices.FirstOrDefault(i => i.DeviceKey == key);
        DeviceType dt = DataProvider.DeviceTypes.FirstOrDefault(i => i.DeviceTypeName.Trim() == SwitchInfo.DeviceType.Trim());
        if (dt == null)
        {
            dt = DataProvider.DeviceTypes.Add(new DeviceType()
            {
                DeviceTypeName = SwitchInfo.DeviceType.Trim(),
                DeviceTypeKey = SwitchInfo.DeviceType.Trim().ToLower().Replace(" ", "_")
            });
        }
        toUpdate.DeviceType = dt;
        toUpdate.BuildingId = Convert.ToInt32(ddlBuilding.SelectedValue);
        toUpdate.DeviceKey = SwitchInfo.DeviceKey;
        toUpdate.HostName = SwitchInfo.HostName;
        toUpdate.IpAddress = SwitchInfo.IPAddress;
        //toUpdate.InterfaceInformations = new List<InterfaceInformation>();
        foreach (BasicInterfaceInformation item in InterfaceInfo)
        {
            InterfaceInformation interf = toUpdate.InterfaceInformations.FirstOrDefault(i => i.InterfaceIndex == item.IfIndex);
            interf.PortNumber = item.IfNumber;
            interf.HasCdpInfo = item.IfCdpExist;
            interf.InterfaceIndex = item.IfIndex;
            interf.InterfaceName = item.IfDescription;
            interf.IsConnected = item.IfConnected;
            interf.IsOpen = item.IfStat;
            interf.LastCheckTime = DateTime.Now;
        }
        DataProvider.SaveChanges();
        Response.Redirect("Default.aspx");
    }
}