PROCEDURE PL_TRAER_BASE IS
	vcApn_periodo VARCHAR2(6);
        vcApn_periodo1 VARCHAR2(6);
	vcError		VARCHAR2(1900);
	vcInstruccion	VARCHAR2(1900);
	dtPmg_fecini 	DATE;
	dtPmg_fecfin 	DATE;
        fecinivar 	DATE;
        Vcperiodo_Ul    Varchar2(10); 
        Nmbasehistnov   Number(12):=0;
        vcfecing        DATE;   
        NmBaseibc       Number(12):=0;
--
--Cursor de las incapacidad que ha tenido el contrato
   Cursor cuinc is 
   Select inc_base 
    From incapacidad 
     where tdc_td_pal=:incapacidad.tdc_td_pal
     And Emp_nd_pal  =:incapacidad.Emp_nd_pal
     And CTO_NUMERO  =:incapacidad.Cto_numero
     And inc_FEcini <:incapacidad.Inc_Fecini
     And inc_contin=3
     ORDER BY Inc_Fecini Desc; 
--
	PROCEDURE error(vcMensaje VARCHAR2) IS
		Resp      BOOLEAN;
		vcError2  VARCHAR2(2000);
	BEGIN
		SET_APPLICATION_PROPERTY(CURSOR_STYLE,'DEFAULT');
		SHOW_EDITOR('EDITOR_error',vcMensaje,vcError2,Resp);
	END;

BEGIN
    SET_APPLICATION_PROPERTY(CURSOR_STYLE,'BUSY');
-- Inicio 2013/03/06 Dario fernando Escobar Cerón v6123de GERS 97722  
  -- Adición fpl_Ambiente  se Sincroniza el código con 10g
  -- Fin
IF fpl_Ambiente !='6I' THEN
--WMWMWMWMWMWMWMWMWMWMWWMWMWMWMWMWMWMWMWMWMWWMWMWMWMWMWMWMWMWMWMWWMWMWMWMWMWMWMWMWMWMWWMWMWMWMWMWMWMWMWMWMWWMWMWMWMWMWMWMWMWMWMWWMWMWMWMWMWMWMWMWMWMW
--Constantes
:incapacidad.vcincapa_ley	:=SUBSTR(	fb_constante_car('INCAPA_LEY',:incapacidad.inc_fecha,:incapacidad.tdc_td_pal,:incapacidad.emp_nd_pal,:incapacidad.tdc_td_fil,:incapacidad.emp_nd_fil,:incapacidad.Suc,NULL),1,1);
:incapacidad.vcinc_base :=SUBSTR(fb_constante_car('INC_BASE',:incapacidad.inc_fecha,:incapacidad.tdc_td_pal,:incapacidad.emp_nd_pal,:incapacidad.tdc_td_fil,:incapacidad.emp_nd_fil,:incapacidad.Suc,NULL),1,3);
:incapacidad.vcconno :=substr(fb_constante_car('CONNO',:incapacidad.inc_fecha,:incapacidad.tdc_td_pal,:incapacidad.emp_nd_pal,	NULL,NULL,NULL,NULL),1,2);
:incapacidad.vcfinlibro:=substr(fb_constante_car('FINLIBRO',sysdate,:incapacidad.tdc_td_pal,:incapacidad.emp_nd_pal,NULL,NULL,NULL,NULL),1,6);
:control.ctomatpri :=SUBSTR(fb_constante_car('CTOMATPRI',sysdate,:incapacidad.tdc_td_pal,:incapacidad.emp_nd_pal,:incapacidad.tdc_td_fil,:incapacidad.emp_nd_fil,:incapacidad.Suc,NULL),1,1);
--WMWMWMWMWMWMWMWMWMWMWWMWMWMWMWMWMWMWMWMWMWWMWMWMWMWMWMWMWMWMWMWWMWMWMWMWMWMWMWMWMWMWWMWMWMWMWMWMWMWMWMWMWWMWMWMWMWMWMWMWMWMWMWWMWMWMWMWMWMWMWMWMWMW
END IF;
 Begin
   select
    TO_CHAR(to_date(
    TO_CHAR(to_date(
    TO_CHAR(to_date(
    TO_CHAR(to_date(
    TO_CHAR(to_date(
    TO_CHAR(to_date(
    TO_CHAR(to_date(
    TO_CHAR(to_date(
    TO_CHAR(to_date(
    TO_CHAR(to_date(
    TO_CHAR(to_date(
    A.APE_PERIODO||'01',
    'YYYYMMDD')-1,'YYYYMM')||'01',
    'YYYYMMDD')-1,'YYYYMM')||'01',
    'YYYYMMDD')-1,'YYYYMM')||'01',
    'YYYYMMDD')-1,'YYYYMM')||'01',
    'YYYYMMDD')-1,'YYYYMM')||'01',
    'YYYYMMDD')-1,'YYYYMM')||'01',
    'YYYYMMDD')-1,'YYYYMM')||'01',
    'YYYYMMDD')-1,'YYYYMM')||'01',
    'YYYYMMDD')-1,'YYYYMM')||'01',
    'YYYYMMDD')-1,'YYYYMM')||'01',
    'YYYYMMDD')-1,'YYYYMM')
    INTO Vcperiodo_Ul
     From Aporte_Param B,Aportes A
      Where B.Tdc_Td  = A.Tdc_Td
       And B.Emp_Nd  = A.Emp_Nd
       And B.Apo_Consec  = A.Apo_Consec
       And B.Apn_Periodo = A.Ape_Periodo
       And B.Pro_Codigo  = 300
       And A.Tdc_Td      = :incapacidad.tdc_td_pal
       And A.Emp_Nd      =:incapacidad.emp_nd_pal
       And A.Tdc_Td_Epl  =:incapacidad.tdc_td_epl
       And A.Epl_Nd  =     :incapacidad.epl_nd
       And A.Ten_Sigla  = 'EPS'
       And A.Ape_Periodo=to_char(:incapacidad.inc_fecini,'YYYYMM');
 Exception 
   When no_data_found then 
    Vcperiodo_Ul:=to_char(:incapacidad.cto_fecing,'YYYYMM');
   -- 
   If Vcperiodo_Ul is null then 
       select cto_fecing into vcfecing 
               From contrato 
                    where tdc_td=:incapacidad.tdc_td_pal
                    And emp_nd=:incapacidad.emp_nd_pal
                    And Cto_numero=:incapacidad.cto_numero;
        Vcperiodo_Ul:=to_char(vcfecing,'YYYYMM');
   End if;
   --
  End;
--WMWMWMWMWMWMWMWMWMWMWWMWMWMWMWMWMWMWMWMWMWWMWMWMWMWMWMWMWMWMWMWWMWMWMWMWMWMWMWMWMWMWWMWMWMWMWMWMWMWMWMWMWWMWMWMWMWMWMWMWMWMWMWWMWMWMWMWMWMWMWMWMWMW
  vcInstruccion := 'pl_traer_base '||'vcApn_periodo := ';
	/*
	vcApn_periodo := 
		to_char(
			to_date(to_char(:incapacidad.inc_fecini,'YYYYMM'||'01'),'YYYYMMDD')
			- 1,'YYYYMM');
			*/
		--hqb20070216
		vcApn_periodo := TO_CHAR(TRUNC(:incapacidad.inc_fecini,'MM')-1,'YYYYMM');
--WMWMWMWMWMWMWMWMWMWMWWMWMWMWMWMWMWMWMWMWMWWMWMWMWMWMWMWMWMWMWMWWMWMWMWMWMWMWMWMWMWMWWMWMWMWMWMWMWMWMWMWMWWMWMWMWMWMWMWMWMWMWMWWMWMWMWMWMWMWMWMWMWMW
   If :Incapacidad.inc_contin = 1 Then 
       ---Hqb--se devuelve dos periodo
       vcApn_periodo1 :=to_char(to_date(vcApn_periodo||'01','YYYYMMDD')-1,'YYYYMM');
      vcApn_periodo:=vcApn_periodo1;
   End If;
  :incapacidad.inc_periodo:=vcApn_periodo;
--WMWMWMWMWMWMWMWMWMWMWWMWMWMWMWMWMWMWMWMWMWWMWMWMWMWMWMWMWMWMWMWWMWMWMWMWMWMWMWMWMWMWWMWMWMWMWMWMWMWMWMWMWWMWMWMWMWMWMWMWMWMWMWWMWMWMWMWMWMWMWMWMWMW
     
        fecinivar :=to_date(Vcperiodo_Ul||'01','YYYYMMDD');
   --hqb20070216
   dtPmg_fecini :=TRUNC(:incapacidad.inc_fecini,'MM');
  /*        
	dtPmg_fecini :=
		to_date(to_char(:incapacidad.inc_fecini,'YYYYMM'||'01'),'YYYYMMDD')
		-1;
		*/
	
	--dtPmg_fecini := to_date(to_char(dtPmg_fecini,'YYYYMM'||'01'),'YYYYMMDD');
	 --hqb20070216
	dtPmg_fecini := TRUNC(:incapacidad.inc_fecini,'MM');
	dtPmg_fecfin := LAST_DAY(dtPmg_fecini);

	vcInstruccion := 'pl_traer_base '||
		'if :incapacidad.vcinc_base = IBC then ';
--&&
 If :incapacidad.vcinc_base = 'IBC' then
--  
	If :incapacidad.inc_prorro='S' And :Incapacidad.inc_contin = 3 Then   
  	    Alerta('o', 'Se va ha tomar como base para liquidar esta incapacidad la base de la incapacidad anterior');
  	     Open cuinc;
	     FETCH cuinc into NmBaseibc;
	     Close cuinc;
	     :incapacidad.inc_base:=NmBaseibc;
  	Else 
	    Nmbasehistnov :=fb_base_histnov
				(
				:incapacidad.tdc_td_pal,
				:incapacidad.emp_nd_pal,
				:incapacidad.cto_numero,
				219,		
				fecinivar,
				dtPmg_fecini,
				:incapacidad.tdc_td_fil,
				:incapacidad.emp_nd_fil	
				);

	  If  Nmbasehistnov > 0 and :Incapacidad.inc_contin != 3 then  --de acuerdo a  mail enviado por leonardo las incapacidades por acc de trabajo no se deben pormediar
	      alerta('o','ha este Empleado se le va ha calcular un ibc variable.Revise'); 
	      :incapacidad.inc_base:=fb_base_promedio_12m(
			        :incapacidad.tdc_td_pal,
				:incapacidad.emp_nd_pal,
				:incapacidad.tdc_td_epl,
				:incapacidad.epl_nd,
				vcApn_periodo,
				'EPS',
                                :incapacidad.Cto_numero);
	   Else   ---Nmbasehistnov > 0 and :Incapacidad.inc_contin != 3 then 
                 IF  :Incapacidad.inc_contin = 3 Then   
		 :incapacidad.inc_base :=greatest(fb_base_aporte(:incapacidad.tdc_td_pal,:incapacidad.emp_nd_pal,:incapacidad.tdc_td_epl,:incapacidad.epl_nd,vcApn_periodo,'EPS'),
                                         fb_sueldo(:incapacidad.tdc_td_pal,:incapacidad.emp_nd_pal,:incapacidad.cto_numero,'M',:incapacidad.inc_fecini)); 
		Else    
		 :incapacidad.inc_base :=fb_base_aporte
				(
				:incapacidad.tdc_td_pal,
				:incapacidad.emp_nd_pal,
				:incapacidad.tdc_td_epl,
				:incapacidad.epl_nd,
				vcApn_periodo,
				'EPS'
                                );
		End if;    
	 End if;				

		:control.instruccion := 'Base autoliquidaciòn '||vcApn_periodo;
		vcInstruccion := 'pl_traer_base '||
			'if :incapacidad.vcinc_base = IBC then '||
			'if :incapacidad.inc_base < 1 then';
		--
		if :incapacidad.inc_base < 1 then
			:incapacidad.inc_base := 
						fb_sueldo
						(
						:incapacidad.tdc_td_pal,
						:incapacidad.emp_nd_pal,
						:incapacidad.cto_numero,
						'M',
						:incapacidad.inc_fecini
						);

						:control.instruccion := 'Base sueldo mensual desde '||
						to_char(:incapacidad.inc_fecini);
		End if;	-- if :incapacidad.inc_base < 1 then

  End if;  --:incapacidad.inc_prorro='S' And :Incapacidad.inc_contin = 3 Then   
 End if; 	--if :incapacidad.vcinc_base = 'IBC' then

 --&&
-- i.Base según devengado.
--
	vcInstruccion := 
		'pl_traer_base '||
		'if :incapacidad.vcinc_base = DEV then';
	if :incapacidad.vcinc_base = 'DEV' then
		:incapacidad.inc_base :=
			fb_base_histnov
				(
				:incapacidad.tdc_td_pal,
				:incapacidad.emp_nd_pal,
				:incapacidad.cto_numero,
				100,				--nmGrb_codigo
				dtPmg_fecini,
				dtPmg_fecfin,
				:incapacidad.tdc_td_fil,	--vcTdc_td_fil
				:incapacidad.emp_nd_fil		--nmEmp_nd_fil
				);


		:control.instruccion :=
			TO_CHAR(dtPmg_fecini)	||' '||
			TO_CHAR(dtPmg_fecfin)	||' '||
			' Base devengado ';

		vcInstruccion := 'pl_traer_base '||
			'if :incapacidad.vcinc_base = DEV then '||
			'if :incapacidad.inc_base < 1 then';
		if :incapacidad.inc_base < 1 then
			:incapacidad.inc_base := 
				fb_sueldo
					(
					:incapacidad.tdc_td_pal,
					:incapacidad.emp_nd_pal,
					:incapacidad.cto_numero,
					'M',
					:incapacidad.inc_fecini
					);

			:control.instruccion := 'Base sueldo mensual desde '||
				to_char(:incapacidad.inc_fecini);

		end if;
		-- if :incapacidad.inc_base < 1 then

		if :incapacidad.inc_base < :incapacidad.smlv then
			vcInstruccion :=
				'Base'				||' '||
				to_char(:incapacidad.inc_base)	||' '||
				'inferior al smlv'		||' '||
				to_char(:incapacidad.smlv)	||' '||
				', busca autoliquidación';
			alerta('o',vcInstruccion);
			:incapacidad.inc_base :=
				fb_base_aporte
					(
					:incapacidad.tdc_td_pal,
					:incapacidad.emp_nd_pal,
					:incapacidad.tdc_td_epl,
					:incapacidad.epl_nd,
					vcApn_periodo,
					'EPS'
					);
		end if;
		--if :incapacidad.inc_base < :incapacidad.smlv then

	end if;
	--if :incapacidad.vcinc_base = 'DEV' then
--
-- f.Base según devengado.
--
	vcInstruccion := 'pl_traer_base '||
		'if :incapacidad.vcinc_base = SUE then ';
	if :incapacidad.vcinc_base = 'SUE' then
		:incapacidad.inc_base := 
			fb_sueldo
				(
				:incapacidad.tdc_td_pal,
				:incapacidad.emp_nd_pal,
				:incapacidad.cto_numero,
				'M',
				:incapacidad.inc_fecini
				);
		:control.instruccion := 'Base sueldo mensual desde '||
				to_char(:incapacidad.inc_fecini);

		if :incapacidad.inc_base < :incapacidad.smlv then
			vcInstruccion :=
				'Base'				||' '||
				to_char(:incapacidad.inc_base)	||' '||
				'inferior al smlv'		||' '||
				to_char(:incapacidad.smlv);
			alerta('o',vcInstruccion);
		end if;
		--if :incapacidad.inc_base < :incapacidad.smlv then

	end if;
	--if :incapacidad.vcinc_base = 'SUE' then

	SET_APPLICATION_PROPERTY(CURSOR_STYLE,'DEFAULT');

EXCEPTION 
	WHEN VALUE_ERROR THEN
		vcError := vcError||vcInstruccion||SQLERRM;
		error	(vcError);
	WHEN OTHERS THEN
		vcError := vcError||vcInstruccion||SQLERRM;
		error	(vcError);
END;