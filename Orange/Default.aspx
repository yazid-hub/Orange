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

<h2>  Liste des interventions </h2>
<%

 string chaine = "<table border = 1> <tr> <td> Id Intervention </td> <td> Description </td> ";
        chaine += "<td> Date </td> <td> Statut </td> <td> Montant </td> <td> Technicien </td> <td> Client</td> </tr> ";

        List <Orange.Intervention> lesInterventions = uneBDD.selectAllInterventions();

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
