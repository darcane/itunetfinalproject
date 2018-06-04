<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Details.aspx.cs" Inherits="Device_Details" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphTitle" Runat="Server">
    ITUNET - Device Details
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphHead" Runat="Server">
    <style type="text/css">
        .input-group .input-group-prepend .input-group-text {
            width: 112px;
        }

        .qrimage {
            width: 300px;
        }

        .progress {
            height: 38px;
        }

        .progress-bar {
            height: 38px;
        }
        .fa-rotate-305{
            -ms-filter: "progid:DXImageTransform.Microsoft.BasicImage(rotation=1)";
            -webkit-transform: rotate(305deg);
            -ms-transform: rotate(305deg);
            transform: rotate(305deg);
        }
    </style>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphBreadcrumb" Runat="Server">
    <li class="breadcrumb-item">
        <a href="/Default.aspx"><i class="fa fa-dashboard"></i>&nbsp;Dashboard</a>
    </li>
    <li class="breadcrumb-item">
        <a href="/Device/Default.aspx"><i class="fa fa-server fa-rotate-180"></i>&nbsp;Device</a>
    </li>
    <li class="breadcrumb-item active"><i class="fa fa-microchip"></i>&nbsp;Device Details</li>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="cphContent" Runat="Server">
    <h2>Device Details - <%=SwitchInfo.IPAddress %></h2>
    <div class="row">
        <div class="col col-xl-4">
            <div class="card mb-3">
                <div class="card-header">General Info</div>
                <div class="card-body">
                    <fieldset disabled>
                        <div class="form-group input-group">
                            <div class="input-group-prepend">
                                <span class="input-group-text">Host Name</span>
                            </div>
                            <asp:TextBox ID="tbHostName" CssClass="form-control" runat="server"></asp:TextBox>
                        </div>
                        <div class="form-group input-group">
                            <div class="input-group-prepend">
                                <span class="input-group-text">Device Type</span>
                            </div>
                            <asp:TextBox ID="tbDeviceType" CssClass="form-control" runat="server"></asp:TextBox>
                        </div>
                        <div class="form-group input-group">
                            <div class="input-group-prepend">
                                <span class="input-group-text">Device Key</span>
                            </div>
                            <asp:TextBox ID="tbDeviceKey" CssClass="form-control" runat="server"></asp:TextBox>
                        </div>
                    </fieldset>
                    <div class="form-group input-group">
                        <div class="input-group-prepend">
                            <span class="input-group-text">Building</span>
                        </div>
                        <asp:DropDownList ID="ddlBuilding" runat="server" DataValueField="BuildingId" DataTextField="BuildingName" CssClass="form-control"></asp:DropDownList>
                    </div>
                    <div class="form-group">
                        <asp:Panel ID="pnlDeviceExist" runat="server" Visible="false">
                            <asp:LinkButton ID="lbUpdateDevice" runat="server" CssClass="btn btn-info pull-right" OnClick="lbUpdateDevice_Click" ClientIDMode="Static">
                                <i class="fa fa-refresh"></i>&nbsp;Update Device
                            </asp:LinkButton>
                        </asp:Panel>
                    </div>
                </div>
            </div>
            <div class="card">
                <div class="card-header">CDP Information</div>
                <div class="card-body">
                    <asp:Repeater ID="rpCdp" runat="server">
                        <HeaderTemplate>
                            <table class="table table-striped table-sm text-center">
                                <thead class="thead-dark">
                                    <tr>
                                        <th>Con. Port</th>
                                        <th>CDP Addr.</th>
                                        <th>Hostname</th>
                                        <th>Port on</th>
                                    </tr>
                                </thead>
                                <tbody>
                        </HeaderTemplate>
                        <ItemTemplate>
                                    <tr>
                                        <td>
                                            <asp:HiddenField ID="hdnCdpIfIndex" runat="server" Value=' <%#Eval("cdpIfIndex") %>' />
                                            <asp:Label ID="lblCdpConnectedPort" runat="server"></asp:Label></td>
                                        <td><%#Eval("cdpAddress")%></td>
                                        <td><%#Eval("cdpDeviceId") %></td>
                                        <td><%#Eval("cdpDevicePort").ToString().Replace("FastEthernet","Fa ").Replace("GigabitEthernet", "Gi ") %></td>
                                    </tr>
                        </ItemTemplate>
                        <FooterTemplate>
                                    <%if (rpCdp.Items.Count == 0)
                                        {%>
                                    <tr>
                                        <td colspan="4" class="alert alert-danger">CDP information not exist.</td>
                                    </tr>
                                    <%} %>
                                </tbody>
                            </table>
                        </FooterTemplate>
                    </asp:Repeater>
                </div>
            </div>
        </div>
        <div class="col col-xl-8">
            <div class="row">
                <div class="col col-xl-8">
                    <div class="card">
                        <div class="card-header">Interface Information</div>
                        <div class="card-body">
                            <asp:GridView runat="server" ID="gv"></asp:GridView>
                            <asp:Repeater ID="rpInterfaces" runat="server">
                                <HeaderTemplate>
                                    <table class="table table-striped table-sm text-center ">
                                        <thead class="thead-dark">
                                            <tr>
                                                <th></th>
                                                <th scope="col">Index</th>
                                                <th scope="col">Description</th>
                                                <th scope="col">Port Number</th>
                                                <th scope="col">CDP Exist</th>
                                                <th scope="col">Open</th>
                                                <th scope="col">Connected</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <tr >
                                        <td><%#Convert.ToBoolean(Eval("IsUpdated")) ? "<span class=\"badge badge-success fa-rotate-305\">New</span>": "" %></td>
                                        <td scope="row"><%#Eval("IfIndex") %></td>
                                        <td><%#Eval("IfDescription") %></td>
                                        <td><%#Eval("IfNumber") %></td>
                                        <td><%#Convert.ToBoolean(Eval("IfCdpExist")) ? "<img src=\"/Content/ico_green.png\" />": "<img src=\"/Content/ico_red.png\" />"%></td>
                                        <td><%#Convert.ToBoolean(Eval("IfStat")) ? "<img src=\"/Content/ico_green.png\" />": "<img src=\"/Content/ico_red.png\" />"%></td>
                                        <td><%#Convert.ToBoolean(Eval("IfConnected")) ? "<img src=\"/Content/ico_green.png\" />": "<img src=\"/Content/ico_red.png\" />"%></td>
                                    </tr>
                                </ItemTemplate>
                                <FooterTemplate>
                                        </tbody>
                                    </table>
                                </FooterTemplate>
                            </asp:Repeater>
                        </div>
                    </div>
                </div>
                <div class="col col-xl-4">
                    <div class="card">
                        <div class="card-header">QR Code</div>
                        <img runat="server" id="imgQR" class="card-img-top" src="#" />
                        <div class="card-body">
                            <div class="card-title">QR Code Link</div>
                            <a href="#" runat="server" id="qrHref" class="card-link"></a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="cphFooterJs" Runat="Server">
    <script type="text/javascript">
        $(document).ready(() => {
            $("#lbUpdateDevice").hover(()=>$("#lbUpdateDevice").children("i").toggleClass("fa-spin"));
        });
    </script>
</asp:Content>

