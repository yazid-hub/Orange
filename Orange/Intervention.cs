using System;
namespace Orange
{
    public class Intervention
    {
        private int idInter;
        private string description, dateinter, statut;
        private float montant;
        private string technicien, client;


        public Intervention()
        {
            this.idInter = 0;
            this.description = "";
            this.dateinter = "";
            this.statut = "";
            this.montant = 0;
            this.technicien = "";
            this.client = "";
        }
        public Intervention(int idInter, string description, string dateinter, string statut, float montant, string technicien, string client)
        {
            this.idInter = idInter;
            this.description = description;
            this.dateinter = dateinter;
            this.statut = statut;
            this.montant = montant;
            this.technicien = technicien;
            this.client = client;
        }
        public Intervention(string description, string dateinter, string statut, float montant, string technicien, string client)
        {
            this.idInter = 0;
            this.description = description;
            this.dateinter = dateinter;
            this.statut = statut;
            this.montant = montant;
            this.technicien = technicien;
            this.client = client;
        }
        public int IDInter
        {
            get
            {
                return this.idInter;
            }
            set
            {
                this.idInter = value;
            }
        }
        public string DESCRIPTION
        {
            get
            {
                return this.description;
            }
            set
            {
                this.description = value;
            }
        }
        public string DATEINTER
        {
            get
            {
                return this.dateinter;
            }
            set
            {
                this.dateinter = value;
            }
        }
        public string STATUT
        {
            get
            {
                return this.statut;
            }
            set
            {
                this.statut = value;
            }
        }
        public string TECHNICIEN
        {
            get
            {
                return this.technicien;
            }
            set
            {
                this.technicien = value;
            }
        }
        public string CLIENT
        {
            get
            {
                return this.client;
            }
            set
            {
                this.client = value;
            }
        }
        public float MONTANT
        {
            get
            {
                return this.montant;
            }
            set
            {
                this.montant = value;
            }
        }
    }
}
