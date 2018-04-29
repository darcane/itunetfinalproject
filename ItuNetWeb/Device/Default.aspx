<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="Device_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphTitle" Runat="Server">
    ITUNET - Devices
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphHead" Runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphBreadcrumb" Runat="Server">
    <li class="breadcrumb-item">
        <a href="/Default.aspx"><i class="fa fa-dashcube"></i>&nbsp;Dashboard</a>
    </li>
    <li class="breadcrumb-item active"><i class="fa fa-keyboard-o"></i>&nbsp;Devices</li>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="cphContent" Runat="Server">
    <div class="card mb-3">
        <div class="card-header">
            <i class="fa fa-list"></i><strong> Device List</strong>
            <span class="pull-right">
                <a href="DeviceAdd.aspx" class="btn btn-sm btn-success"><i class="fa fa-plus"></i> Add Device</a>
            </span>
        </div>
        <div class="card-body">
            <div class="table-responsive">
                <table id="dataTable" class="table table-bordered">
                    <thead>
                        <tr>
                            <th>Id</th>
                            <th>Host Name</th>
                            <th>Ip Address</th>
                            <th>Key</th>
                            <th>Device Type</th>
                            <th>Building</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <asp:Repeater ID="rpBuilding" runat="server">
                        <ItemTemplate>
                            <tr>
                                <td><%#Eval("DeviceId") %></td>
                                <td><%#Eval("HostName") %></td>
                                <td><%#Eval("IpAddress") %></td>
                                <td><%#Eval("DeviceKey") %></td>
                                <td><%#Eval("DeviceType.DeviceTypeName") %></td>
                                <td><%#Eval("Building.BuildingName") %></td>
                                <td>
                                    <a href="#" title="Edit"><i class="fa fa-pencil"></i></a>
                                    <a href="#" title="Delete"><i class="fa fa-trash"></i></a>
                                </td>
                            </tr>
                        </ItemTemplate>
                        <FooterTemplate>
                            <%if(rpBuilding.Items.Count == 0){%>
                            <tr>
                                <td colspan="7" class="text-danger"><i>No Data Found</i></td>
                            </tr>
                            <%}%>
                        </FooterTemplate>
                    </asp:Repeater>
                </table>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="cphFooterJs" Runat="Server">
</asp:Content>

