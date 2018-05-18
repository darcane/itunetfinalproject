<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="DeviceAdd.aspx.cs" Inherits="Device_DeviceAdd" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphTitle" runat="Server">
    ITUNET - Add Device
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphHead" runat="Server">
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
<asp:Content ID="Content3" ContentPlaceHolderID="cphBreadcrumb" runat="Server">
    <li class="breadcrumb-item">
        <a href="/Default.aspx"><i class="fa fa-dashboard"></i>&nbsp;Dashboard</a>
    </li>
    <li class="breadcrumb-item">
        <a href="/Device/Default.aspx"><i class="fa fa-hdd"></i>&nbsp;Device</a>
    </li>
    <li class="breadcrumb-item active"><i class="fa fa-plus"></i>&nbsp;Add Device</li>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="cphContent" runat="Server">
    <h2>Add Device</h2>
    <div class="alert alert-info alert-dismissible">
        <button type="button" class="close" data-dismiss="alert" aria-hidden="true">x</button>
        By giving IP Address; program will automatically detect the device and add to the system.
    </div>
    <div class="row">
        <div class="col col-xl-6">
            <div class="form-group input-group">
                <div class="input-group-prepend">
                    <span class="input-group-text">IP Address</span>
                </div>
                <asp:TextBox ID="tbIPAddress" runat="server" CssClass="form-control" ClientIDMode="Static"></asp:TextBox>
                <div class="input-group-append">
                    <asp:LinkButton ID="lbAddDevice" CssClass="btn btn-success" runat="server" OnClick="lbAddDevice_Click" ClientIDMode="Static">
                        <i class="fa fa-plus"></i> Add Device
                    </asp:LinkButton>
                </div>
            </div>
        </div>
        <div class="col col-xl-4">
            &nbsp;
            <%--<div id="loadingBar2" class="progress-bar progress-bar-striped progress-bar-animated bg-success" style="width: 0%"></div>--%>
        </div>
    </div>
    <asp:Panel ID="pnlAfterAdd" runat="server" Visible="false" ClientIDMode="Static">
        <div class="row">
            <div class="col col-xl-4">
                <div class="card">
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
                            <asp:Panel ID="pnlDeviceNotExist" runat="server" Visible="true">
                                <asp:LinkButton ID="lbSaveDevice" runat="server" CssClass="btn btn-primary pull-right" OnClick="lbSaveDevice_Click" ClientIDMode="Static">
                                    <i class="fa fa-save"></i>&nbsp;Save Device
                                </asp:LinkButton>
                            </asp:Panel>
                            <asp:Panel ID="pnlDeviceExist" runat="server" Visible="false">
                                <div class="alert alert-danger">Device already exist!</div>
                                <asp:LinkButton ID="lbUpdateDevice" runat="server" CssClass="btn btn-info pull-right" OnClick="lbUpdateDevice_Click" ClientIDMode="Static">
                                    <i class="fa fa-refresh"></i>&nbsp;Update Device
                                </asp:LinkButton>
                            </asp:Panel>
                        </div>
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
    </asp:Panel>
    <div class="modal fade" id="modalLoading" tabindex="-1" role="dialog" aria-labelledby="loadingModal" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-body">
                    <div class="progress" style="display: none">
                        <div id="loadingBar" class="progress-bar progress-bar-striped progress-bar-animated bg-success" style="width: 0%"></div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="cphFooterJs" runat="Server">
    <script src="/Scripts/jquery-mask/jquery.mask.js"></script>
    <script type="text/javascript">
        $(document).ready(() => {
            $("#tbIPAddress").mask('0ZZ.0ZZ.0ZZ.0ZZ', {
                translation: {
                    'Z': {
                        pattern: /[0-9]/, optional: true
                    }
                },
                placeholder: "___.___.___.___"
            });
            //$('#tbIPAddress').mask('099.099.099.099');

            if ($("#pnlAfterAdd").length) {
                $("#lbAddDevice").children("i").removeClass("fa-plus");
                $("#lbAddDevice").text("In Progress");
                $("#lbAddDevice").addClass("disabled");
            };

            $("#lbAddDevice").one("click", (e) => {
                e.preventDefault();
                $("#modalLoading").modal({});
                $("#lbAddDevice").children("i").removeClass("fa-plus").addClass("fa-spin fa-spinner");
                $("#lbAddDevice").addClass("disabled");
                triggerProgressBar();
            });
            $("#lbUpdateDevice").hover(()=>$("#lbUpdateDevice").children("i").toggleClass("fa-spin"));
        });

        function triggerProgressBar() {
            animateProgressBar();
            $(".progress").show();
            var progress = 1;
            var increment = 0.5;
            var messages = [
                "Connecting device...",
                "Getting Device informations...",
                "Getting interface informations...",
                "Generating DeviceKey...",
                "Generating QR Code...",
            ];
            function animateProgressBar() {
                setTimeout(() => {
                    increment = (Math.random() * (0.1 - 3) + 3);
                    console.log(increment);
                    progress += increment;
                    if (progress < 101) {
                        $("#loadingBar").css("width", progress + "%");
                        $("#loadingBar").html(messages[parseInt(progress / 20)]);
                        animateProgressBar();
                    } else {
                        $("#loadingBar").html("Completed!");
                        setTimeout(() => {
                            var f = new Function($("#lbAddDevice").attr("href"));
                            return (f());
                        }, 1000);
                    }
                }, 50);
            }
        }


    </script>
</asp:Content>

