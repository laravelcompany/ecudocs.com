SUPPORT CHECK V1 / AUTOIDENT V1
  Alliance_ECUs_01_1_0_0.odx-d
    Date        : 15/06/2019
    Evolutions  :
      + 1ere version officielle

  Alliance_ECUs_01_3_0_0.odx-d
    Date        : 25/11/2019
    Evolutions  :
      + Surcharge des paramètres de communication
          * CP_TesterPresentAddrMode
          * CP_TesterPresentReqRsp
      + Modification du service SecurityAccess
          * Ajout des securityAccessType $01/$02, $05/$06 et $07/$08
          * Ajout des états et transision pour ces nouveaux types

  Alliance_ECUs_01_5_0_0.odx-d
    Date        : 28/02/2020
    Evolutions  :
      + Correction/évolution du service $1902 :
          o Raison : La structure DtcStatusMask utilisée dans la réponse (dans la partie EOPDU field) définie
            des valeurs par défaut ce qui pose problème lorsque la réponse differt de ces valeurs.
          o Avant:
            * Requête:
                La donnée DTCStatusMask point en ID-REF sur la structure DtcStatusMask définie dans le fichier Alliance_DatasFormat.odx-d.
            * Réponse:
                La donnée DtcStatusAvailabilityMask pointe en SN-REF sur la structure DtcStatusAvailabilityMask définie dans le fichier  Alliance_ECUs.
                Les données DtcStatus pointent en ID-REF sur la structure DTCStatusMask définie dans le fichier Alliance_DatasFormat.odx-d.
          o Après:
            * Requête:
                La donnée DTCStatusMask pointe en SN-REF sur la structure DtcStatusMask définie dans le fichier Alliance_ECUs
                == > Cela permet une surcharge pour emettre autre chose que $1902FF
          * Réponse:
              La donnée DtcStatusAvailabilityMask pointe en ID-REF sur la structure DtcStatusAvailabilityMask définie dans le fichier Alliance_DatasFormat.odx-d
              Les données DtcStatus pointent en ID-REF sur la nouvelle structure DtcStatus définie dans le fichier Alliance_DatasFormat.odx-d. Cette dernière n'a pas de valeur par défaut.
  Alliance_ECUs_01_5_0_1.odx-d
    Date        : 31/03/2021
    Evolutions  :
      + Modification du nombre de Snapshot record autorisé 0 -> 254 au lieu de 1 -> 5(modification des TEXTTABLE DtcSnapshotRecordNumbersRQ et DtcSnapshotRecordNumbersPR)


SUPPORT CHECK V2 / AUTOIDENT V1
  Alliance_ECUs_01_2_0_0.odx-d
    Date        : 30/09/2019
    Evolutions  :
      + 1ere version officielle

  Alliance_ECUs_01_4_0_0.odx-d
    Date        : 25/11/2019
    Evolutions  :
      + Surcharge des paramètres de communication
          * CP_TesterPresentAddrMode
          * CP_TesterPresentReqRsp
      + Modification du service SecurityAccess
          * Ajout des securityAccessType $01/$02, $05/$06 et $07/$08
          * Ajout des états et transision pour ces nouveaux types

  Alliance_ECUs_01_6_0_0.odx-d
    Date        : 28/02/2020
    Evolutions  :
      + Intégration des services $190F (copie de $1902 corrigé) et $1910 (copie de $1906 corrigé)
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

  Alliance_ECUs_01_6_0_1.odx-d
    Date        : 24/04/2020
    Correction  :
      + Service Supported Writeable DIDs, suppression du 3 eme paramètre (SUBFUNCTION - octect 4) qui n'existe pas dans la vrai trame.
          == > Trame du fichier originale SID DID 00
          == > Trame du fichier corrigée  SID DID

  Alliance_ECUs_01_6_0_2.odx-d
    Date        : 03/06/2020
    Correction  :
      + Service Supported Writeable DIDs, correction de la valeur du SID pour la requête et la réponse
          == > Trame du fichier originale 2E DID / 6E DID ....
          == > Trame du fichier corrigée  22 DID / 62 DID ...

  Alliance_ECUs_01_6_0_3.odx-d
    Date        : 27/04/2021
    Evolutions  :
      + Modification du nombre de Snapshot record autorisé 0 -> 254 au lieu de 1 -> 5(modification des TEXTTABLE DtcSnapshotRecordNumbersRQ et DtcSnapshotRecordNumbersPR)
      + Ajout des protocols CAN-FD (11 et 29 bits)

SUPPORT CHECK V2 / AUTOIDENT V2
  Alliance_ECUs_01_7_0_0.odx-d
    Date        : 28/02/2020
    Evolutions  :
      + 1ere version officielle issue de Alliance_ECUs_01_6_0_0.odx-d
  Alliance_ECUs_01_7_0_1.odx-d
    Date        : 27/04/2021
    Evolutions  :
      + Modification du nombre de Snapshot record autorisé 0 -> 254 au lieu de 1 -> 5(modification des TEXTTABLE DtcSnapshotRecordNumbersRQ et DtcSnapshotRecordNumbersPR)
      + Ajout des protocols CAN-FD (11 et 29 bits)
      
