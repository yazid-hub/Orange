using System;
using MySql.Data.MySqlClient;
using System.Collections.Generic;
using System.Data.Common;


namespace Orange
{
    public class Bdd
    {
        private string serveur, bdd, user, mdp;
        private MySqlConnection maConnexion;

        public Bdd(string serveur, string bdd, string user, string mdp)
        {
            this.serveur = serveur;
            this.bdd = bdd;
            this.user = user;
            this.mdp = mdp;
            string url = "SERVER=" + this.serveur + ";port=3306" + ";Database=" + this.bdd + "; User Id=" + this.user + ";password=" + this.mdp;
            //attention pour les PC port =3306

            try
            {
                this.maConnexion = new MySqlConnection(url);
                Console.WriteLine("Connexion réussie");
            }
            catch (Exception exp)
            {
                Console.WriteLine("Erreur de connexion à : " + url);
                Console.WriteLine(exp.Message);
            }

        }
        public List<Intervention> selectAllInterventions(string mot = "")
        {
            List<Intervention> lesInterventions = new List<Intervention>();
            string requete = "";
            if (mot == "")
            {
                requete = "select * from intervention ; ";
            }
            else
            {
                requete = "select * from intervention where statut like '%" + mot + "%' or description like '%" + mot + "%' or technicien like '%" + mot
                    + "%' or client like '%" + mot + "%' ; ";
            }

            try
            {
                //ouverture de la connexion Mysql
                this.maConnexion.Open();
                //creation de la commande SQL
                MySqlCommand cmd = this.maConnexion.CreateCommand();

                cmd.CommandText = requete;

                //parcourir les enregistrements de la table
                DbDataReader unReader = cmd.ExecuteReader();
                try
                {
                    if (unReader.HasRows)
                    {
                        while (unReader.Read())
                        {
                            Intervention uneIntervention = new Intervention(
                                unReader.GetInt32(0), unReader.GetString(1), unReader.GetString(2), unReader.GetString(4), unReader.GetFloat(3),
                                unReader.GetString(5), unReader.GetString(6)
                                );
                            lesInterventions.Add(uneIntervention);
                        }
                    }
                }
                finally
                {
                    Console.WriteLine("Erreur d'extraction des données de la table ");
                }

                //fermeture de la connexion 
                this.maConnexion.Close();
            }
            catch (Exception exp)
            {
                Console.WriteLine("Erreur d'exécution de la requete :" + requete);
                Console.WriteLine(exp.Message);
            }

            return lesInterventions;
        }
        public void insertIntervention(Orange.Intervention uneIntervention)
        {
            string requete = "";
            try
            {
                this.maConnexion.Open();

                requete = "insert into intervention values (null, @description, @dateinter,  @montant , @statut, @technicien, @client );";

                MySqlCommand cmd = this.maConnexion.CreateCommand();

                cmd.CommandText = requete;

                //correspondance des parametres et des valeurs
                cmd.Parameters.AddWithValue("@description", uneIntervention.DESCRIPTION);
                cmd.Parameters.AddWithValue("@dateinter", uneIntervention.DATEINTER);
                cmd.Parameters.AddWithValue("@montant", uneIntervention.MONTANT);
                cmd.Parameters.AddWithValue("@statut", uneIntervention.STATUT);
                cmd.Parameters.AddWithValue("@technicien", uneIntervention.TECHNICIEN);
                cmd.Parameters.AddWithValue("@client", uneIntervention.CLIENT);

                //on execute la requete
                cmd.ExecuteNonQuery();

                this.maConnexion.Close();
            }
            catch (Exception exp)
            {
                Console.WriteLine("Erreur d'execution de la requete :" + requete);
                Console.WriteLine(exp.Message);

            }
        }

        public void deleteIntervention(int idInter)
        {
            string requete = "";
            try
            {
                this.maConnexion.Open();

                requete = "delete from intervention where idinter = @idinter ;";

                MySqlCommand cmd = this.maConnexion.CreateCommand();

                cmd.CommandText = requete;

                //correspondance des parametres et des valeurs
                cmd.Parameters.AddWithValue("@idinter", idInter);

                //on execute la requete
                cmd.ExecuteNonQuery();

                this.maConnexion.Close();
            }
            catch (Exception exp)
            {
                Console.WriteLine("Erreur d'execution de la requete :" + requete);
                Console.WriteLine(exp.Message);
            }
        }

        public void updateIntervention(Orange.Intervention uneIntervention)
        {
            string requete = "";
            try
            {
                this.maConnexion.Open();

                requete = "update intervention set description= @description, dateinter= @dateinter, montant= @montant , statut =@statut,  technicien = @technicien, client = @client where idinter = @idinter ;";

                MySqlCommand cmd = this.maConnexion.CreateCommand();

                cmd.CommandText = requete;

                //correspondance des parametres et des valeurs
                cmd.Parameters.AddWithValue("@description", uneIntervention.DESCRIPTION);
                cmd.Parameters.AddWithValue("@dateinter", uneIntervention.DATEINTER);
                cmd.Parameters.AddWithValue("@montant", uneIntervention.MONTANT);
                cmd.Parameters.AddWithValue("@statut", uneIntervention.STATUT);
                cmd.Parameters.AddWithValue("@technicien", uneIntervention.TECHNICIEN);
                cmd.Parameters.AddWithValue("@client", uneIntervention.CLIENT);
                cmd.Parameters.AddWithValue("@idinter", uneIntervention.IDInter);
                //on execute la requete
                cmd.ExecuteNonQuery();

                this.maConnexion.Close();
                Console.WriteLine(uneIntervention.IDInter);
            }
            catch (Exception exp)
            {
                Console.WriteLine("Erreur d'execution de la requete :" + requete);
                Console.WriteLine(exp.Message);
            }
        }

    public Intervention selectWhereIntervention(int idInter)
        {
            Intervention uneIntervention = null;
            string requete = "select * from intervention where  idInter = @idinter ; ";
            try
            {
                //ouverture de la connexion Mysql
                this.maConnexion.Open();
                //creation de la commande SQL
                MySqlCommand cmd = this.maConnexion.CreateCommand();
                cmd.CommandText = requete;
                cmd.Parameters.AddWithValue("@idinter", idInter);

                //parcourir les enregistrements de la table
                DbDataReader unReader = cmd.ExecuteReader();
                try
                {
                    if (unReader.HasRows)
                    {
                        if (unReader.Read())
                        {
                            uneIntervention = new Intervention(
                               unReader.GetInt32(0), unReader.GetString(1), unReader.GetString(2), unReader.GetString(4), unReader.GetFloat(3),
                               unReader.GetString(5), unReader.GetString(6)
                               );
                        }
                    }
                }
                finally
                {
                    Console.WriteLine("Erreur d'extraction des données de la table ");
                }
                //fermeture de la connexion 
                this.maConnexion.Close();
            }
            catch (Exception exp)
            {
                Console.WriteLine("Erreur d'exécution de la requete :" + requete);
                Console.WriteLine(exp.Message);
            }
            return uneIntervention;
        }
    }
}
