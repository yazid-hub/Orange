<%@page language="C#"%>
<%@ Import Namespace="System.Collections.Generic"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8" />
    <title></title>
</head>
<body>
    <h1>Gestion des interventions</h1>
<%
   Orange.Bdd uneBDD = new Orange.Bdd("localhost", "orangeC","root",""); // pas de mdp pour les PC
%>
 %>
          <form method="post" action="">
              <table border  ="0">
                  <tr>
                      <td>Description</td><td> <textarea name="description" rows ="10" cols="100"></textarea></textarea></td>
                  </tr>
                   <tr>
                      <td>Date Intervention</td><td> <input type="date" name="dateinter"></td>
                  </tr>
                  <tr>
                      <td>Statut </td><td> <select  name="statut">
                          
                          <option value="programée">Programmée</option>
                          <option value="terminée">terminée</option>
                          <option value="en cours">En cours</option>
                          </select>
                          </td>
                  </tr>
                  <tr>
                      <td>Montant a payer</td><td> <input type="text" name="montant"></td>
                  </tr>
                  <tr>
                      <td>Technicien</td><td> <input type="text" name="technicien"></td>
                  </tr>
                  <tr>
                      <td>Client</td><td> <input type="text" name="client"></td>
                  </tr>
                  <tr>
                      <td> <input type="reset" name="annuler" value="annuler"></td><td><input type="submit" name="valider" value="valider"></td>
                  </tr>

              </table>
          </form>
    <% 
        if(Request.Form["valider"] != null)
        {
            string description = Request.Form["description"];
            string dateinter = Request.Form["dateinter"];
            string statut = Request.Form["statut"];
            float montant =float.Parse( Request.Form["montant"]);
            string technicien = Request.Form["technicien"];
            string client = Request.Form["client"];

            Orange.Intervention uneIntervention = new Orange.Intervention(description, dateinter, statut, montant, technicien, client);

            uneBDD.insertIntervention(uneIntervention);

        }

<h2>  Liste des interventions </h2>
<%

 string chaine = "<table border = 1> <tr> <td> Id Intervention </td> <td> Description </td> ";
        chaine += "<td> Date </td> <td> Statut </td> <td> Montant </td> <td> Technicien </td> <td> Client</td> </tr> ";

        List <Orange.Intervention> lesInterventions = uneBDD.selectAllInterventions ();

        foreach (Orange.Intervention uneIntervention in lesInterventions)
        {
        chaine += "<tr> <td>" +uneIntervention.iDinter+"</td> <td>" + uneIntervention.DESCRIPTION
        + "</td> <td>" + uneIntervention.DATEINTER + "</td> <td>" + uneIntervention.STATUT + "</td> <td>"+ uneIntervention.MONTANT
        + "</td> <td>" + uneIntervention.TECHNICIEN + "</td> <td>" + uneIntervention.CLIENT +"</td></tr>";
        }

        chaine+="</table>";
%>
        <%=chaine%>


</body>
</html>
