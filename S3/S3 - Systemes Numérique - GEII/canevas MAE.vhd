--*******************************************************
--	Titre 		: CANEVAS Machine A Etat Fini AMZI
--
--	Auteur 		: SELKIM Omar
--	Date		: 26 octobre 2014
--
--	Description	:
--		Ceci est un squelette de machine a etat seulement
--		il faut remplacer les entrées  nomées "input" par
--		les entrée du  systeme et faire de même pour  les
--		sortie.  Remplacer  egalement  les condition  au
--		transitions ainsi que les action sur etat/transi-
--		tion. ENJOY ! ;)
--
--*******************************************************
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


library WORK;
use WORK.LE_PACK_UTILISATEUR.ALL;

entity MAE is
  PORT(
    ck,arazb    :in std_logic;
    input_1     :in std_logic;
    input_2     :in std_logic_vector(3 downto 0);
    output_1    :out std_logic;
    output_2    :out std_logic_vector(3 downto 0)
    );
end MAE;

architecture ARCHI_1 of MAE is
--Definition des etat de la MAE et création d'un type associé
  type etat_mae is (etat0,etat1,etat2);
  signal etat_present,etat_suivant      :etat_mae;
--Definition des signaux de transition de la MAE
  signal T0,T1  :std_logic;

  begin
 --Calcul des signaux de transition

    T0 <= '1' when (condition1),
          '1' when (condition2),
          '0' when others;
    T1 <= '1' when (condition1),
          '1' when (condition2),
          '0' when others;


    --Bloc de memorisation

    process(ck,arazb)
      begin
        if arazb='0' then
          etat_present <= etat0;
        elsif ck'event and ck='1' then
          etat_present <= etat_suivant;
        end if;
    end process;

    --Bloc evolution
    process(ck,arazb,T0,T1)
      begin
         case etat_present is
           when etat0 => if T0='1' then etat_suivant <= etat1 else etat_suivant <= etat0 end if;
           when etat1 => if T1='1' then etat_suivant <= etat2 else etat_suivant <= etat1 end if;
           when etat2 => if T2='1' then etat_suivant <= etat0 else etat_suivant <= etat2 end if;
         end case;
     end process;

    --Bloc action sur etat
	with etat_present select
       		output_1 <=	"VAL1" when etat0,
                  		"VAL2" when etat1,
                   		"VAL3" when etat2,
		   		"Valeur par default" when others;
	with etat_present select
		output_2 <=	"VALA" when etat0,
				"VALB" when etat1,
				"VALC" when etat2,
				"Valeur par default" when others;
    --Bloc action sur Transition (MAZI)
	output_1 <=	"val0" when T0='1' AND etat_present=etat0 else
			"val1" when T1='1' AND etat_present=etat1 else
			"val2" when T2='1' AND etat_present=etat2 else
			'O'; --MAZI
	output_2 <=	"valA" when T0='1' AND etat_present=etat0 else
			"valB" when T1='1' AND etat_present=etat1 else
			"valC" when T2='1' AND etat_present=etat2 else
			'0'; --MAZI

	--Voila c'est a peut pret tout pour cette MAE en MAZI
	---Vous pouvez eventuellement la refaire a votre sauce

end ARCHI_1;
