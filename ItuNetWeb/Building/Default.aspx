<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="Building_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphTitle" Runat="Server">
    ITUNET - Buildings
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphHead" Runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphBreadcrumb" Runat="Server">
    <li class="breadcrumb-item">
        <a href="/Default.aspx"><i class="fa fa-dashboard"></i>&nbsp;Dashboard</a>
    </li>
    <li class="breadcrumb-item active"><i class="fa fa-building"></i>&nbsp;Building</li>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="cphContent" Runat="Server">
    <div class="card mb-3">
        <div class="card-header">
            <i class="fa fa-list"></i><strong> Building List</strong>
            <span class="pull-right">
                <a href="BuildingAdd.aspx" class="btn btn-sm btn-success"><i class="fa fa-plus"></i> Add Building</a>
            </span>
        </div>
        <div class="card-body">
            <div class="table-responsive">
                <table id="dataTable" class="table table-bordered">
                    <thead>
                        <tr>
                            <th>Id</th>
                            <th>Name</th>
                            <th>Key</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <asp:Repeater ID="rpBuilding" runat="server">
                        <ItemTemplate>
                            <tr>
                                <td><%#Eval("BuildingId") %></td>
                                <td><%#Eval("BuildingName") %></td>
                                <td><%#Eval("BuildingKey") %></td>
                                <td>
                                    <a href="#" title="Edit"><i class="fa fa-pencil"></i></a>
                                    <a href="#" title="Delete"><i class="fa fa-trash"></i></a>
                                </td>
                            </tr>
                        </ItemTemplate>
                        <FooterTemplate>
                            <%if(rpBuilding.Items.Count == 0){%>
                            <tr>
                                <td colspan="4" class="text-danger"><i>No Data Found</i></td>
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
    <%--<script src="/Scripts/sb-admin-datatables.js"></script>--%>
    <script type="text/javascript">
        $(document).ready(() => {
            //$("#dataTable").DataTable();
        });
    </script>
</asp:Content>

