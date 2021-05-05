<%@ Page Title="" Language="C#" MasterPageFile="~/PageMaitre.Master" AutoEventWireup="true" CodeBehind="Lot.aspx.cs" Inherits="Chifsm.WebForm1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
        <div>
            <asp:ScriptManager ID="ScriptManager1" EnableHistory="false" runat="server" EnableScriptGlobalization="true" EnableScriptLocalization="true">              
            </asp:ScriptManager>
          
           <div class="row">
               <div class="col-lg-2">
                    
               </div>
              
               <div class="col-lg-8">

                     <asp:UpdatePanel ID="UpdatePanelDonnee" runat="server" style="margin:40px 0px 0px 0px">
                        <ContentTemplate>
                        <div class="table-component" >
                        <div class="table-top">
                        <div class="input">
                          <asp:TextBox ID="TextGo" runat="server"></asp:TextBox>
                            
                        <div class="button-group">
                            <asp:LinkButton ID="search" runat="server" BackColor="LightBlue" CssClass="button" OnClick="Go"><span aria-hidden="true" class="glyphicon glyphicon-search"></span></asp:LinkButton>
                         </div>
                        
                        <div class="">
                            <asp:Label ID="ButtonRecherche" runat="server" BackColor="LightBlue" Text="Chercher par mots clés" CssClass="prepend" Font-Bold="true" />
                            <asp:Button ID="Button1" runat="server" Text="Chercher par mots clés" CssClass="" Font-Bold="true" OnClick="Go" style="display:none"/>
                        </div>
                           
                           </div>
                             <div style="margin:0px 0px -24px 0px">
                         <h3 ><a href="Lot.aspx"style="color:#FF6F61">Liste des Lots</a></h3>
                            <asp:LinkButton ID="LinkButtonPlus" runat="server" ForeColor="MidnightBlue"  OnClick="Add"><span aria-hidden="true" class="glyphicon glyphicon-plus"></span></asp:LinkButton>
                         </div>
                            
                       </div>
                              
                            <asp:GridView ID="GridView1" runat="server" class="table table-striped table-bordered mt-4" OnSorting="GridView_Sorting" BackColor="White" AllowSorting="true" ForeColor="Black" BorderColor="Blue" CellSpacing="-1" ShowHeaderWhenEmpty="true" EmptyDataText="No data found" AutoGenerateColumns="false" DataKeyNames="Id">
                               <Columns>
                                       <asp:BoundField DataField="Id" HeaderText="S.No" InsertVisible="False" ReadOnly="True" SortExpression="Id"  ItemStyle-CssClass="hiddencol" HeaderStyle-CssClass="hiddencol" />
                                       <asp:BoundField DataField="Label" HeaderText="Label" SortExpression="Label" ItemStyle-CssClass="" HeaderStyle-CssClass="" />
                                       <asp:BoundField DataField="IdProduit" HeaderText="IdProduit" SortExpression="IdProduit" Visible="true" ItemStyle-CssClass="hiddencol" HeaderStyle-CssClass="hiddencol" />
                                       <asp:BoundField DataField="CAS" HeaderText="CAS" SortExpression="CAS" Visible="true" ItemStyle-CssClass="hiddencol" HeaderStyle-CssClass="hiddencol" />
                                       <asp:BoundField DataField="Purete" HeaderText="Purété" SortExpression="Purete" />
                                       <asp:BoundField DataField="Concentration" HeaderText="Concentration" SortExpression="Concentration" Visible="true" ItemStyle-CssClass="hiddencol" HeaderStyle-CssClass="hiddencol" />
                                       <asp:BoundField DataField="DatePreemption" HeaderText="Date Préemption" SortExpression="DatePreemption" Visible="true" ItemStyle-CssClass="hiddencol" HeaderStyle-CssClass="hiddencol" />
                                       <asp:BoundField DataField="TypeContenant" HeaderText="Type Contenant" SortExpression="TypeContenant" Visible="true" ItemStyle-CssClass="hiddencol" HeaderStyle-CssClass="hiddencol" />
                                       <asp:BoundField DataField="UniteContenant" HeaderText="Unité Contenant" SortExpression="UniteContenant" />
                                       <asp:BoundField DataField="CapaciteContenant" HeaderText="Capacité Contenant" SortExpression="CapaciteContenant" Visible="true" ItemStyle-CssClass="hiddencol" HeaderStyle-CssClass="hiddencol" />
                                       <asp:TemplateField ItemStyle-Width="75px" HeaderText="Action">
                                           <ItemTemplate>
                                                 <asp:LinkButton ID="IdDetail" runat="server" OnClick="Detail_Click"><i class="glyphicon glyphicon-book"></i></asp:LinkButton>
                                                <asp:LinkButton ID="IdEdit" runat="server" OnClick="Edit_Click"><i class="glyphicon glyphicon-edit"></i></asp:LinkButton>
                                                <asp:LinkButton ID="IdDelete" runat="server" OnClick="Delete_Click"><i class="glyphicon glyphicon-remove"></i></asp:LinkButton>
                                           </ItemTemplate>
                                       </asp:TemplateField>
                                   </Columns>
                              </asp:GridView>
                               <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:AspNetCrudConnectionString %>" SelectCommand="SELECT DISTINCT * FROM [Lot]"></asp:SqlDataSource>
                               </div>
                            <div>     
                            <asp:Panel ID="PanelEdit" runat="server" CssClass="modalpopup">
                                <span id="ButtonAnnuler1" class="close">&times;</span>
                                <br/>
                                 <table class="nav-justified" id="tab">
                                     <tr>
                                        <th colspan="2">
                                            <asp:Label ID="LabelTitre" runat="server" Text="Label"></asp:Label>

                                        </th>
                                    </tr>
                                    <tr>
                                        <td colspan="2"><asp:Label ID="Lottitre" Text="Lot:" runat="server" ></asp:Label>
                                          <asp:Label ID="LabelLot" runat="server" Text="Label"></asp:Label></td>
                                    </tr>
                                    <tr class="hiddencol">
                                        <th>No du Lot:</th>
                                        <td><div>
                                            <asp:TextBox ID="TextId" runat="server" BorderWidth="2px" BorderStyle="Dotted" placeholder="à ne pas remplir"></asp:TextBox>
                                            </div></td>
                                    </tr>
                                    <tr>
                                        <th>Produit:</th>
                                        <td>
                                            <div class="input">
                                                 
                                            <asp:DropDownList ID="DropDownList1" runat="server"  DataSourceID="SqlDataSourceDrop"  DataTextField="Reference" BorderWidth="2px" BorderStyle="Dotted" AutoPostBack="false" BackColor="LightBlue"   DataValueField="Id" Visible="true">
                                                
                                            </asp:DropDownList>
                                                   
                                            
                                            <asp:SqlDataSource runat="server" ID="SqlDataSourceDrop" ConnectionString='<%$ ConnectionStrings:AspNetCrudConnectionString %>' SelectCommand="SELECT [Id], [Reference], [CAS] FROM [Produit]"></asp:SqlDataSource>
                                           
                                              <asp:TextBox ID="TextIdProduit" runat="server" Visible="false"></asp:TextBox>
                                                
                                        
                                            </div>
                                        </td>
                                       
                                    </tr>
                                    <tr>
                                        <th>Purete:</th>

                                        <td><div>
                                            <asp:TextBox ID="TextPurete" BorderWidth="2px" BorderStyle="Dotted" placeholder="Purété.." runat="server"></asp:TextBox></div></td>
                                    </tr>
                                    <tr>
                                        <th>Concentration:</th>
                                        <td><div>
                                            <asp:TextBox ID="TextConcentration" BorderWidth="2px" BorderStyle="Dotted" placeholder="Concentration.." runat="server"></asp:TextBox></div></td>
                                    </tr>
                                    <tr>
                                        <th>Date Préemption:</th>
                                        <td>
                                            <asp:TextBox ID="TextDatePreemption" BorderWidth="2px" BorderStyle="Dotted" runat="server" placeholder="JJ/MM/AAAA" CssClass="date"></asp:TextBox>
                                           
                                        </td>
                                    </tr>
                                    <tr>
                                        <th style="padding:2px">Type Contenant:</th>
                                        <td style="padding:2px"><div>
                                            <asp:TextBox ID="TextTypeContenant" runat="server" BorderWidth="2px" placeholder="Type contenant.." BorderStyle="Dotted"></asp:TextBox></div></td>
                                    </tr>
                                    <tr>
                                        <th style="padding:2px">Unité Contenant:</th>
                                        <td style="padding:2px"><div>
                                            <asp:TextBox ID="TextUniteContenant" runat="server" BorderWidth="2px" placeholder="Unité.." BorderStyle="Dotted"></asp:TextBox></div></td>
                                    </tr>
                                    <tr>
                                        <th style="padding:2px">Capacité Contenant:</th>
                                        <td  style="padding:2px"><div>
                                            <asp:TextBox ID="TextCapaciteContenant" placeholder="Capacité.."  runat="server" BorderWidth="2px" BorderStyle="Dotted"></asp:TextBox>
                                            </div></td>
                                    </tr>
                                     <tr >
                                        <td style="padding:8px;align-content:center" colspan="2">
                                            <asp:Button ID="ButtonOk" runat="server" CssClass="buttonok" OnClick="Ok" Text="Ok" />
                                           
                                            <asp:Button ID="ButtonAnnuler" runat="server" CssClass="button" Text="Annuler" Visible="true"/>
                                            <asp:Button ID="DatePlus"  runat="server" OnClick="Plus_Date" Text="+Date"/> 
                                        </td>
                                     </tr>
                                </table>
                               </asp:Panel>
                            </div> 
                            <asp:LinkButton ID="LinkButton2" runat="server"></asp:LinkButton>
                             <ajaxToolkit:CalendarExtender ID="CalendarExtender1" CssClass="MyCalendar" runat="server" TargetControlID="TextDatePreemption" Animated="true"  />
                            <ajaxToolkit:ModalPopupExtender ID="ModalPopupExtender1" TargetControlID="LinkButton2" CancelControlID="ButtonAnnuler1" PopupControlID="PanelEdit" BackgroundCssClass="modalBackground21" runat="server"></ajaxToolkit:ModalPopupExtender>
                            
                          </ContentTemplate>
                            <Triggers>
                            <asp:AsyncPostBackTrigger ControlID = "GridView1" />
                            <asp:AsyncPostBackTrigger ControlID = "ButtonOk" />
                            </Triggers>
                       </asp:UpdatePanel>
                  

               </div>
              
               <div class="col-lg-2">

               </div>

           </div>
               <div class="row">
                   <div class="col-lg-12">

                   </div>
               </div>
         
        </div>
   
    <script type="text/javascript">
                function myFunction(){

                    if (outerWidth < 885) {
                        document.getElementById("navbarl").style.display = "none";
                       
                        document.getElementById("Btnnav").style.display = "inline";
                    }
                    else {
                        document.getElementById("navbarl").style.display = "inline";
                        document.getElementById("Btnnav").style.display = "none";
                    }
                    //alert('Width' + outerWidth+'height' + outerHeight);
                }
                // When the user scrolls down 80px from the top of the document, resize the navbar's padding and the logo's font size
                var prevScrollpos = window.pageYOffset;
                function btn() {
                    
                    var list = document.getElementById("navlist");
                    if (list.style.display == "none") { list.style.display = "inline";}
                    else { list.style.display = "none";}
                              
                }
                window.onscroll = function() {
                var currentScrollPos = window.pageYOffset;
                  if (prevScrollpos > currentScrollPos) {
                    document.getElementById("navbar1").style.top = "0";
                  } else {
                      document.getElementById("pr").style.display = "none";
                    document.getElementById("navbar1").style.top = "-50px";
                  }
                  prevScrollpos = currentScrollPos;
                }
            </script>

</asp:Content>
