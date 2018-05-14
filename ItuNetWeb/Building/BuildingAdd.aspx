<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="BuildingAdd.aspx.cs" Inherits="Building_BuildingAdd" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphTitle" runat="Server">
    ITUNET - Add Building
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphHead" runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphBreadcrumb" runat="Server">
    <li class="breadcrumb-item">
        <a href="/Default.aspx"><i class="fa fa-dashboard"></i>&nbsp;Dashboard</a>
    </li>
    <li class="breadcrumb-item">
        <a href="/Building/Default.aspx"><i class="fa fa-building"></i>&nbsp;Building</a>
    </li>
    <li class="breadcrumb-item active"><i class="fa fa-plus"></i>&nbsp;Add Building</li>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="cphContent" runat="Server">
    <div class="col-lg-6">
        <div class="form-group">
            <label>Building Name</label>
            <asp:TextBox ID="tbBuildingName" runat="server" ClientIDMode="Static" CssClass="form-control"></asp:TextBox>
        </div>
        <div class="form-group">
            <label>Building Key</label>
            <fieldset disabled>
                <input type="text" id="tbBuildingKey" class="form-control" />
            </fieldset>
        </div>
        <div class="form-group">
            <asp:Button ID="btnAddBuilding" CssClass="btn btn-success" runat="server" OnClick="btnAddBuilding_Click" Text="Add Building" />
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="cphFooterJs" runat="Server">
    <script type="text/javascript">
        $(document).ready(() => {
            $("#tbBuildingName").on('keyup', () => {
                var key = $("#tbBuildingName").val().toLowerCase().replace(/\s/g, "-");
                $("#tbBuildingKey").val(key);
            });
        });
    </script>
</asp:Content>

