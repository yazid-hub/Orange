<%@ Page Language="C#"%>
<%@  Import Namespace="System.Collections.Generic" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8" />
    <title></title>
</head>
<body>
    <h1> Gestion des interventions </h1> 
        <%
        Orange.Bdd uneBDD = new Orange.Bdd ("localhost","orangec", "root","") ; //pas de mdp pour les PC 
        
        //instanciation d'une intervention de modification 
        Orange.Intervention uneInter = null ;
        if (Request["action"] != null && Request["idinter"] != null && Request["action"] == "edit" ) 
        {
            int idinter = int.Parse (Request["idinter"]); 
            uneInter = uneBDD.selectWhereIntervention(idinter); 
        }
        %>
        <form method="post" action="">
        <table border="0">
             <tr>
                <td> Description </td> <td> <textarea name="description"  rows="10" cols="50"><%= (uneInter==null)? "":uneInter.DESCRIPTION %></textarea> </td>       
             </tr>
             <tr>
                <td> Date Intervention  </td> <td> <input type="text" name="dateinter" value ="<%= (uneInter==null)? "":uneInter.DATEINTER %>"> </td>       
             </tr> 
             <tr>
                <td> Statut  </td> <td> <select name="statut"> 
                        <option value="programmée"> Programmée </option>
                        <option value="terminée"> Terminée </option>
                        <option value="en cours"> En cours </option>
                           </select>
                    </td>       
             </tr> 
              <tr>
                <td>Montant à payer</td> <td> <input type="text" name="montant" value ="<%= (uneInter==null)? "":uneInter.MONTANT+"" %>" > </td>       
             </tr> 
              <tr>
                <td> Technicien</td> <td> <input type="text" name="technicien" value ="<%= (uneInter==null)? "":uneInter.TECHNICIEN %>"> </td>       
             </tr> 
              <tr>
                <td> Client</td> <td> <input type="text" name="client"  value ="<%= (uneInter==null)? "":uneInter.CLIENT %>"> </td>       
             </tr> 
              <tr>
                <td> <input type="reset" name="Annuler" value="Annuler">  </td> <td> 
                    <input type="submit" <%= (uneInter==null)?"name='Valider' value='Valider'":"name='Modifier' value='Modifier'" %> >   </td>       
             </tr> 
                <input type="hidden" name="idinter" value ="<%= (uneInter==null)? "":uneInter.IDInter+"" %>">
        </table>
        </form>
        
        <%
            if (Request.Form["Valider"] != null )
            {
                string description = Request.Form["description"]; 
                string dateinter = Request.Form["dateinter"]; 
                string statut = Request.Form["statut"]; 
                float montant = float.Parse (Request.Form["montant"]); 
                string technicien = Request.Form["technicien"];
                string client = Request.Form["client"];
        
                //instanciation de la classe intervention 
                Orange.Intervention uneIntervention = new Orange.Intervention (description, dateinter, statut, montant, technicien, client); 
                
                //insertion dans la base de données de l'intervention saisie 
                uneBDD.insertIntervention(uneIntervention); 
        
            }
            if (Request["action"] != null && Request["idinter"] != null) 
            {   
                int idinter = int.Parse (Request["idinter"]); 
                string action = Request["action"];
        
                if (action == "sup") {
                        //suppression de l'intervention identifiée par id 
                        uneBDD.deleteIntervention (idinter) ;
        
                    } 
                }
            if (Request.Form["Modifier"] != null)
                    {
                        //mise à jour de l'intervention identifiée par id 
                        int idinter = int.Parse(Request.Form["idinter"]); 
                        string description = Request.Form["description"]; 
                        string dateinter = Request.Form["dateinter"]; 
                        string statut = Request.Form["statut"]; 
                        float montant = float.Parse (Request.Form["montant"]); 
                        string technicien = Request.Form["technicien"];
                        string client = Request.Form["client"];
                
                        //instanciation de la classe intervention 
                        Orange.Intervention uneIntervention = new Orange.Intervention (idinter, description, dateinter, statut, montant, technicien, client); 
                        //mise à jour dans la base 
                        uneBDD.updateIntervention (uneIntervention); 
                    }
            
        %>
        
        <h2> Liste des interventions </h2>
        <form method="post" action="">
            Filter par : <input type="text" name="mot"> <input type="submit" name="Rechercher" value="Rechercher">
         </form>
        <%
        
        List<Orange.Intervention> lesInterventions = null; 
        
        string chaine = "<table border= 1 > <tr> <td> Id Intervention</td> <td> Description</td> ";
               chaine += " <td> Date </td><td>Statut </td> <td> Montant </td> <td> Technicien </td> <td> Client </td> <td> Opérations </td> </tr> "; 
        if (Request.Form["Rechercher"] != null)
        {
               lesInterventions = uneBDD.selectAllInterventions (Request.Form["mot"]); 
        }else
        {
             lesInterventions = uneBDD.selectAllInterventions (""); 
        }
        
        foreach (Orange.Intervention uneIntervention in lesInterventions)
        {
            chaine += "<tr> <td>"+uneIntervention.IDInter+ "</td> <td> "+ uneIntervention.DESCRIPTION 
            + "</td> <td>" + uneIntervention.DATEINTER +"</td> <td> " + uneIntervention.STATUT +"</td> <td> "+uneIntervention.MONTANT 
            + "</td> <td>" + uneIntervention.TECHNICIEN +"</td> <td> "+uneIntervention.CLIENT+"</td> "
            + " <td> "
            + "    <a href='Default.aspx?action=sup&idinter=" + uneIntervention.IDInter + "'> Supprimer</a> "
            + "    <a href='Default.aspx?action=edit&idinter=" + uneIntervention.IDInter + "'> Editer </a> "
            + " </td>  </tr>";  
        }
        chaine += "</table>"; 
        %>
        
        <%= chaine %>
</body>
</html>
