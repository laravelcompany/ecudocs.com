Alliance_ECUs_02_1_0_0.odx-d
    Date        : 15/06/2019
    Evolutions  :
      + 1ere version officielle
    
    
Alliance_ECUs_02_1_0_1.odx-d
    Date        : 21/10/2019
    Evolutions  :
      + Ajout des structures d'identification Nissan N2, N3 et N4
      + Lien du service d'identification Nissan ($2183) sur la structure N4 au lieu de N1
      
Alliance_ECUs_02_2_0_0.odx-d
    Date        : 25/11/2019
    Evolutions  :
      + Surcharge des paramètres de communication
          * CP_TesterPresentAddrMode
          * CP_TesterPresentReqRsp
      + Modification du service SecurityAccess
          * Ajout des securityAccessType $01/$02, $05/$06 et $07/$08
          * Ajout des états et transision pour ces nouveaux types
          
Alliance_ECUs_02_3_0_0.odx-d
    Date        : 28/02/2020
    Evolutions  :
      + Correction/évolution du service $1902 :
          o Raison : La structure DtcStatusMask utilisée dans la réponse (dans la partie EOPDU field) définie des valeurs par défaut ce qui pose problème lorsque la réponse differt de ces valeurs.
          o Avant:
            * Requête:
                L'information DTCStatusMask point en ID-REF sur la structure DtcStatusMask définie dans le fichier Alliance_DatasFormat.odx-d.
            * Réponse:
                L'information DtcStatusAvailabilityMask pointe en SN-REF sur la structure DtcStatusAvailabilityMask définie dans le fichier  Alliance_ECUs.
                Les informations DtcStatus pointent en ID-REF sur la structure DTCStatusMask définie dans le fichier Alliance_DatasFormat.odx-d.
          o Après:
            * Requête:
                L'information DTCStatusMask pointe en SN-REF sur la structure DtcStatusMask définie dans le fichier Alliance_ECUs
                == > Cela permet une surcharge pour emettre autre chose que $1902FF
            * Réponse:
                L'information DtcStatusAvailabilityMask pointe en ID-REF sur la structure DtcStatusAvailabilityMask définie dans le fichier Alliance_DatasFormat.odx-d
                Les informations DtcStatus pointent en ID-REF sur la nouvelle structure DtcStatus définie dans le fichier Alliance_DatasFormat.odx-d. Cette dernière n'a pas de valeur par défaut.
      + Correction/évolution du service $1904 :
          o Raison : La structure DtcStatusMask utilisée dans la réponse pour l'information DtcStatus définie des valeurs par défaut ce qui pose problème lorsque la réponse differt de ces valeurs.
          o Avant:
            * Réponse:
                L'information DtcStatus pointe en ID-REF sur la structure DTCStatusMask définie dans le fichier Alliance_DatasFormat.odx-d.
          o Après:
            * Réponse:
                L'information DtcStatus pointe en ID-REF sur la nouvelle structure DtcStatus définie dans le fichier Alliance_DatasFormat.odx-d. Cette dernière n'a pas de valeur par défaut.
      + Correction/évolution du service $1906 :
          o Raison : La structure DtcStatusMask utilisée dans la réponse pour l'information DtcStatus définie 
              des valeurs par défaut ce qui pose problème lorsque la réponse differt de ces valeurs.
          o Avant:
            * Réponse:
                L'information DtcStatus pointe en ID-REF sur la structure DTCStatusMask définie dans le fichier Alliance_DatasFormat.odx-d.
          o Après:
            * Réponse:
                L'information DtcStatus pointe en ID-REF sur la nouvelle structure DtcStatus définie dans le fichier Alliance_DatasFormat.odx-d. Cette dernière n'a pas de valeur par défaut.

Alliance_ECUs_02_3_0_1.odx-d
    Date        : 27/04/2021
    Evolutions  :
      + Modification du nombre de Snapshot record autorisé 0 -> 254 au lieu de 1 -> 5(modification des TEXTTABLE DtcSnapshotRecordNumbersRQ et DtcSnapshotRecordNumbersPR)
      + Ajout des protocols CAN-FD (11 et 29 bits)