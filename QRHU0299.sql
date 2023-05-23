/
 create or replace PACKAGE RHU.QB_APLICATION_JRHU0055 AS 
 --**********************************************************************************************************
--** NOMBRE SCRIPT        : QRHU0299
--** OBJETIVO             : ADMINISTRACION DE GESTOR DE INCAPACIDADES
--** ESQUEMA              : RHU
--** AUTOR                : DEIBY SIERRA
--** FECHA                : 20/02/2023
--**********************************************************************************************************
TYPE REFCURSOR IS REF CURSOR;

PROCEDURE PL_OBTENER_INCAPACIDADES_EPL(
    VCTIPODOCUMENTO VARCHAR2,
    NMDOCUMENTO NUMBER,
    VCTIPODOCUMENTOEMPRE VARCHAR2,
    NMDOCUMENTOPRINCIPAL NUMBER,
    RCINC OUT REFCURSOR,
    VCESTADO_PROCESO OUT VARCHAR2,
    VCMENSAJE_PROCESO OUT VARCHAR2
);

PROCEDURE PL_OBTENER_INC_DEV(
    RCINCDEV OUT REFCURSOR,
    VCESTADO_PROCESO OUT VARCHAR2,
    VCMENSAJE_PROCESO OUT VARCHAR2
);

PROCEDURE PL_OBTENER_TIP_INCAPACIDAD(
    RTIPINCAPACIDAD OUT REFCURSOR,
    VCESTADO_PROCESO OUT VARCHAR2,
    VCMENSAJE_PROCESO OUT VARCHAR2
);

PROCEDURE PL_OBTENER_SUBTIP_INCAPACIDAD(
    NTIPOINC IN NUMBER,
    RSUBINCAPACIDAD OUT REFCURSOR,
    VCESTADO_PROCESO OUT VARCHAR2,
    VCMENSAJE_PROCESO OUT VARCHAR2
);

PROCEDURE PL_OBTENER_DOCUM_SUBTIP(
    NSUBTIPOINC IN NUMBER,
    RDOCUMENSUBTIPO OUT REFCURSOR,
    VCESTADO_PROCESO OUT VARCHAR2,
    VCMENSAJE_PROCESO OUT VARCHAR2
);

PROCEDURE PL_OBTENER_CONTRATOS(
    VTDC_TD_EPL IN VARCHAR2,
    NEPL_ND IN NUMBER,
    NEMP_ND IN NUMBER,
    VTDC_TD IN VARCHAR2,
    RCONTRATOS OUT REFCURSOR,
    VCESTADO_PROCESO OUT VARCHAR2,
    VCMENSAJE_PROCESO OUT VARCHAR2
);

PROCEDURE PL_BUSCAR_TAX_INCAPACIDAD(
    VTDC_TD_EPL IN VARCHAR2,
    NEPL_ND IN NUMBER,
    NMDEACODIGO IN NUMBER,
    NMDEAPADRE OUT NUMBER,
    NMAZCODIGO OUT NUMBER,
    VCESTADO_PROCESO OUT VARCHAR2,
    VCMENSAJE_PROCESO OUT VARCHAR2
);

PROCEDURE PL_BUSCAR_TAX_INCA_INTER(
    NDESCRIP IN VARCHAR2,
    NMDEACODIGO IN NUMBER,
    NMDEAPADRE OUT NUMBER,
    NMAZCODIGO OUT NUMBER,
    VCESTADO_PROCESO OUT VARCHAR2,
    VCMENSAJE_PROCESO OUT VARCHAR2
);

PROCEDURE PL_OBTENER_ENFERMEDAD(
    RSGPENFER OUT REFCURSOR,
    VCESTADO_PROCESO OUT VARCHAR2,
    VCMENSAJE_PROCESO OUT VARCHAR2
);

PROCEDURE PL_OBTENER_TERMINOSYCOND(
    RTERMINO OUT REFCURSOR,
    VCESTADO_PROCESO OUT VARCHAR2,
    VCMENSAJE_PROCESO OUT VARCHAR2
);

PROCEDURE PL_CREAR_RADICADO(
    VCTDOCUMENTO IN VARCHAR2,
    NMDOCUMENTO IN NUMBER,
    NMEMPPRINCIPAL IN NUMBER,
    VCTIPODOCEMPR IN VARCHAR2,
    NMCONTRATO IN NUMBER,
    NMCODGENFE IN NUMBER,
    NMCODSGENFE IN NUMBER,
    VCCODENFER IN VARCHAR2,
    NMCONTINCA IN NUMBER,
    VCFECINCIDENTE IN VARCHAR2,
    VCFECINICIOINCA IN VARCHAR2,
    NMDIAS IN NUMBER,
    VCPRORROGA IN VARCHAR2,
    NMIDUSUARIO IN NUMBER ,
    NMSUBCONTI IN NUMBER,
    NMIPUSUARIO IN VARCHAR,
    VCFECHFUERMATE IN VARCHAR2,
    NMRADICADO OUT NUMBER,
    VCESTADO_PROCESO OUT VARCHAR2,
    VCMENSAJE_PROCESO OUT VARCHAR2
);

PROCEDURE PL_INSERT_RADICACION_DOCUMENT(
    NMRADICADO IN NUMBER,
    NMTPD_CODIGO IN NUMBER,
    VCREQUERIDO IN VARCHAR2
);


PROCEDURE PL_ACTUALIZAR_DOCUMENTO(
    NMDEACODIGO IN NUMBER,
    NMRADICADO  IN NUMBER,
    NMDOCUMENTO IN NUMBER,
    VCESTADO_PROCESO OUT VARCHAR2,
    VCMENSAJE_PROCESO OUT VARCHAR2
);

PROCEDURE PL_LISTAR_DOCUMENTOS(
    VCIPCLIENTE IN VARCHAR2,
    NMRADICADO IN NUMBER,
    RCDOCUMENTOS OUT REFCURSOR,
    VCESTADO_PROCESO OUT VARCHAR2,
    VCMENSAJE_PROCESO OUT VARCHAR2

);

PROCEDURE PL_ACTUALIZAR_ESTADO_OBS(
    NMRADICADO IN NUMBER,
    NMDOCUMENTO IN NUMBER,
    VCOBSERVACION IN VARCHAR2,
    VCESTADO IN VARCHAR2,
    VCESTADO_PROCESO OUT VARCHAR2,
    VCMENSAJE_PROCESO OUT VARCHAR2
);

PROCEDURE PL_VALIDACION_RADICADO(
    VCFECHAINICIO  IN VARCHAR2,
    NMDOCUMENTOEPL IN NUMBER,
    NMCONTRATO IN NUMBER,
    NMNUMERODIAS IN NUMBER,
    VCTIPDOCUMEEPL IN VARCHAR2,
    NMDOCUMENTOPAL IN NUMBER,
    VCTIPODOCUMPAL IN VARCHAR2,
    VCESTADO_PROCESO OUT VARCHAR2,
    VCMENSAJE_PROCESO OUT VARCHAR2
);



PROCEDURE PL_VALIDAR_TAXRADICADO(
    NMRADICADO IN VARCHAR2,
    VCFLUJO IN VARCHAR,
    NMDEAPADRE OUT NUMBER,
    NMAZCODIGO OUT NUMBER,
    VCESTADO_PROCESO OUT VARCHAR2,
    VCMENSAJE_PROCESO OUT VARCHAR2
);

PROCEDURE PL_ACTUALIZAR_EST_RADICADO(
    NMRADICADO IN NUMBER,
    VCESTADO IN VARCHAR,
    VCESTADO_PROCESO OUT VARCHAR2,
    VCMENSAJE_PROCESO OUT VARCHAR2
);

PROCEDURE PL_OBTENER_INCAPACIDADES_CPT(
    RCINC OUT REFCURSOR,
    VCESTADO_PROCESO OUT VARCHAR2,
    VCMENSAJE_PROCESO OUT VARCHAR2
);

PROCEDURE PL_NOTIFICACION(
  VCCORREODESTINO IN VARCHAR2,
  VCCOPIACORREO IN VARCHAR2,
  VCASUNTO IN VARCHAR2,
  VCMENSAJE IN VARCHAR2,
  VCPROCESO OUT VARCHAR2,
  VCESTADO_PROCESO OUT VARCHAR2,
  VCMENSAJE_PROCESO OUT VARCHAR2
);

PROCEDURE PL_CREAR_GERS(
    NMNITEMP IN NUMBER,
    NMDOCUMEPL IN NUMBER,
    VCTIPDOCEMP IN VARCHAR2,
    VCTIDOCEPL IN VARCHAR2,
    NMNUMGERS OUT NUMBER,
    VCESTADO_PROCESO OUT VARCHAR2,
    VCMENSAJE_PROCESO OUT VARCHAR2
);

END QB_APLICATION_JRHU0055;

/ 
create or replace PACKAGE BODY     RHU.QB_APLICATION_JRHU0055 AS
 --**********************************************************************************************************
--** NOMBRE SCRIPT        : QRHU0299
--** OBJETIVO             : CONTIENE LA ADMINISTRACION DE GESTOR DE INCAPACIDADES
--** ESQUEMA              : RHU
--** AUTOR                : DEIBY SIERRA
--** FECHA                : 20/02/2023
--**********************************************************************************************************
PROCEDURE PL_OBTENER_INCAPACIDADES_EPL(
    VCTIPODOCUMENTO VARCHAR2,
    NMDOCUMENTO NUMBER,
    VCTIPODOCUMENTOEMPRE VARCHAR2,
    NMDOCUMENTOPRINCIPAL NUMBER,
    RCINC OUT REFCURSOR,
    VCESTADO_PROCESO OUT VARCHAR2,
    VCMENSAJE_PROCESO OUT VARCHAR2
) IS 
BEGIN 
OPEN RCINC FOR
SELECT DISTINCT(INC.INC_RADICACION),
INC.*,
FB_NOM_EMPRESA(INC.TDC_TD_PAL, INC.EMP_ND_PAL) NOMBRE_EMPRESA_PRINCIPAL,
TINC.TIP_NOMBRE TIPO_INCAPACIDAD,
SINC.SBT_NOMBRE SUB_TIPO_INCAPACIDAD
FROM 
RHU.RAD_DOCUMENTOS RAD , INCAPACIDAD INC ,
RHU.TIP_INCAPACIDAD TINC,  RHU.SBT_INCAPACIDAD SINC
WHERE RAD.INC_RADICACION = INC.INC_RADICACION
AND TINC.TIP_CODIGO=SINC.TIP_CODIGO
AND SINC.SBT_CODIGO = INC.SUBTIPOINC_CODIGO
AND INC.TDC_TD_PAL = VCTIPODOCUMENTOEMPRE
AND INC.EMP_ND_PAL = NMDOCUMENTOPRINCIPAL
AND INC.TDC_TD_EPL = VCTIPODOCUMENTO
AND INC.EPL_ND = NMDOCUMENTO
ORDER BY INC_FECHA_CREACION ASC;

VCESTADO_PROCESO := 'S';
VCMENSAJE_PROCESO := 'Procedimiento ejecutado exitosamente';

EXCEPTION
WHEN OTHERS THEN VCESTADO_PROCESO := 'N';

VCMENSAJE_PROCESO := 'ERROR no controlado en RHU.QB_APLICATION_JRHU0055.PL_OBTENER_INCAPACIDADES_EPL, causada por: 
            ' || SQLERRM || ' -- Linea: ' || dbms_utility.format_error_backtrace();

END PL_OBTENER_INCAPACIDADES_EPL;

PROCEDURE PL_OBTENER_INC_DEV(
    RCINCDEV OUT REFCURSOR,
    VCESTADO_PROCESO OUT VARCHAR2,
    VCMENSAJE_PROCESO OUT VARCHAR2
) IS BEGIN OPEN RCINCDEV FOR
SELECT
    *
FROM
    INCAPACIDAD
WHERE
    INC_ESTADO = 'DEV'
    AND ROWNUM <= 100;

VCESTADO_PROCESO := 'S';

VCMENSAJE_PROCESO := 'Procedimiento ejecutado exitosamente';

EXCEPTION
WHEN OTHERS THEN VCESTADO_PROCESO := 'N';

VCMENSAJE_PROCESO := 'ERROR no controlado en RHU.QB_APLICATION_JRHU0055.PL_OBTENER_INC_DEV, causada por: 
            ' || SQLERRM || ' -- Linea: ' || dbms_utility.format_error_backtrace();

END PL_OBTENER_INC_DEV;

PROCEDURE PL_OBTENER_TIP_INCAPACIDAD(
    RTIPINCAPACIDAD OUT REFCURSOR,
    VCESTADO_PROCESO OUT VARCHAR2,
    VCMENSAJE_PROCESO OUT VARCHAR2
) IS BEGIN OPEN RTIPINCAPACIDAD FOR
SELECT
    *
FROM
    RHU.TIP_INCAPACIDAD
WHERE
    TIP_ESTADO = 'ACTIVO';

VCESTADO_PROCESO := 'S';

VCMENSAJE_PROCESO := 'Procedimiento ejecutado exitosamente';

EXCEPTION
WHEN OTHERS THEN VCESTADO_PROCESO := 'N';

VCMENSAJE_PROCESO := 'ERROR no controlado en RHU.QB_APLICATION_JRHU0055.PL_OBTENER_TIP_INCAPACIDAD, causada por: 
            ' || SQLERRM || ' -- Linea: ' || dbms_utility.format_error_backtrace();

END PL_OBTENER_TIP_INCAPACIDAD;

PROCEDURE PL_OBTENER_SUBTIP_INCAPACIDAD(
    NTIPOINC IN NUMBER,
    RSUBINCAPACIDAD OUT REFCURSOR,
    VCESTADO_PROCESO OUT VARCHAR2,
    VCMENSAJE_PROCESO OUT VARCHAR2
) IS BEGIN OPEN RSUBINCAPACIDAD FOR
SELECT
    *
FROM
    RHU.SBT_INCAPACIDAD
WHERE
    SBT_ESTADO = 'ACTIVO'
    AND TIP_CODIGO = NTIPOINC;

VCESTADO_PROCESO := 'S';

VCMENSAJE_PROCESO := 'Procedimiento ejecutado exitosamente';

EXCEPTION
WHEN OTHERS THEN VCESTADO_PROCESO := 'N';

VCMENSAJE_PROCESO := 'ERROR no controlado en RHU.QB_APLICATION_JRHU0055.PL_OBTENER_SUBTIP_INCAPACIDAD, causada por: 
            ' || SQLERRM || ' -- Linea: ' || dbms_utility.format_error_backtrace();

END PL_OBTENER_SUBTIP_INCAPACIDAD;

PROCEDURE PL_OBTENER_CONTRATOS(
    VTDC_TD_EPL IN VARCHAR2,
    NEPL_ND IN NUMBER,
    NEMP_ND IN NUMBER,
    VTDC_TD IN VARCHAR2,
    RCONTRATOS OUT REFCURSOR,
    VCESTADO_PROCESO OUT VARCHAR2,
    VCMENSAJE_PROCESO OUT VARCHAR2
) IS BEGIN OPEN RCONTRATOS FOR
SELECT
    CTO.*,
    FB_NOM_EMPRESA(TDC_TD_FIL, EMP_ND_FIL) NOMBRE_EMPRESA_USUARIA,
    FB_NOM_EMPRESA(TDC_TD, EMP_ND) NOMBRE_EMPRESA_PRINCIPAL,
    (
        SELECT
            ECT_DESCRIPCION
        FROM
            CTOESTADO
        WHERE
            ECT_SIGLA = CTO.ECT_SIGLA
    ) ESTADO_CONTRATO
FROM
    CONTRATO CTO
WHERE
    ECT_SIGLA = 'ACT'
    AND TDC_TD_EPL = VTDC_TD_EPL
    AND EPL_ND = NEPL_ND
    AND TDC_TD = TDC_TD
    AND EMP_ND = NEMP_ND
UNION
ALL
SELECT
    CTO.*,
    FB_NOM_EMPRESA(TDC_TD_FIL, EMP_ND_FIL) NOMBRE_EMPRESA_USUARIA,
    FB_NOM_EMPRESA(TDC_TD, EMP_ND) NOMBRE_EMPRESA_PRINCIPAL,
    (
        SELECT
            ECT_DESCRIPCION
        FROM
            CTOESTADO
        WHERE
            ECT_SIGLA = CTO.ECT_SIGLA
    ) ESTADO_CONTRATO
FROM
    CONTRATO CTO
WHERE
    ECT_SIGLA = 'RET'
    AND CTO_FECRET BETWEEN SYSDATE - 180
    AND SYSDATE
    AND TDC_TD_EPL = VTDC_TD_EPL
    AND EPL_ND = NEPL_ND
    AND TDC_TD = TDC_TD
    AND EMP_ND = NEMP_ND;

VCESTADO_PROCESO := 'S';

VCMENSAJE_PROCESO := 'Procedimiento ejecutado exitosamente';

EXCEPTION
WHEN OTHERS THEN VCESTADO_PROCESO := 'N';

VCMENSAJE_PROCESO := 'ERROR no controlado en RHU.QB_APLICATION_JRHU0055.PL_OBTENER_CONTRATOS, causada por: 
            ' || SQLERRM || ' -- Linea: ' || dbms_utility.format_error_backtrace();

END PL_OBTENER_CONTRATOS;

PROCEDURE PL_OBTENER_DOCUM_SUBTIP(
    NSUBTIPOINC IN NUMBER,
    RDOCUMENSUBTIPO OUT REFCURSOR,
    VCESTADO_PROCESO OUT VARCHAR2,
    VCMENSAJE_PROCESO OUT VARCHAR2
) IS BEGIN OPEN RDOCUMENSUBTIPO FOR
SELECT
    *
FROM
    RHU.SBT_INCAPACIDAD SINC,
    RHU.SUD_DOCUMENTOS SBDC,
    adm.tipo_documento TPDO
WHERE
    SBDC.SBT_CODIGO = SINC.SBT_CODIGO
    AND TPDO.TPD_CODIGO = SBDC.TPD_CODIGO
    AND SINC.SBT_CODIGO = NSUBTIPOINC
    AND SBDC.SUD_ESTADO = 'ACTIVO';

VCESTADO_PROCESO := 'S';

VCMENSAJE_PROCESO := 'Procedimiento ejecutado exitosamente';

EXCEPTION
WHEN OTHERS THEN VCESTADO_PROCESO := 'N';

VCMENSAJE_PROCESO := 'ERROR no controlado en RHU.QB_APLICATION_JRHU0055.PL_OBTENER_DOCUM_SUBTIP, causada por: 
            ' || SQLERRM || ' -- Linea: ' || dbms_utility.format_error_backtrace();

END PL_OBTENER_DOCUM_SUBTIP;

PROCEDURE PL_BUSCAR_TAX_INCAPACIDAD(
    VTDC_TD_EPL IN VARCHAR2,
    NEPL_ND IN NUMBER,
    NMDEACODIGO IN NUMBER,
    NMDEAPADRE OUT NUMBER,
    NMAZCODIGO OUT NUMBER,
    VCESTADO_PROCESO OUT VARCHAR2,
    VCMENSAJE_PROCESO OUT VARCHAR2
) IS BEGIN
SELECT
    DEA_CODIGO,
    AZD_CODIGO_CLI INTO NMDEAPADRE,
    NMAZCODIGO
FROM
    (
        WITH CARPETA_PADRE AS (
            SELECT
                D1.TXP_CODIGO
            FROM
                ADM.DATA_ERP_AZ D1
            WHERE
                D1.DEA_CODIGO = NMDEACODIGO
        ),
        ELEMENTOS_HIJO AS (
            SELECT
                *
            FROM
                ADM.DATA_ERP_AZ D2
                INNER JOIN ADM.TAXONOMIA_PARAM TAX ON TAX.TXP_CODIGO = D2.TXP_CODIGO
                INNER JOIN CARPETA_PADRE CP ON TAX.TXP_CODIGO_REF = CP.TXP_CODIGO
        )
        SELECT
            HJ.DEA_CODIGO,
            AZ.AZD_CODIGO_CLI
        FROM
            ELEMENTOS_HIJO HJ,
            ADM.AZ_DIGITAL AZ
        WHERE
            AZ.AZD_CODIGO = HJ.AZD_CODIGO
            AND HJ.TXP_DESCRIPCION = VTDC_TD_EPL || ' ' || NEPL_ND
    );

VCESTADO_PROCESO := 'S';

VCMENSAJE_PROCESO := 'Procedimiento ejecutado exitosamente';

EXCEPTION
WHEN OTHERS THEN VCESTADO_PROCESO := 'N';

VCMENSAJE_PROCESO := 'ERROR no controlado en RHU.QB_APLICATION_JRHU0055.PL_BUSCAR_TAXONOMIA_INCAPACIDAD, causada por: 
            ' || SQLERRM || ' -- Linea: ' || dbms_utility.format_error_backtrace();

END PL_BUSCAR_TAX_INCAPACIDAD;

PROCEDURE PL_BUSCAR_TAX_INCA_INTER(
    NDESCRIP IN VARCHAR2,
    NMDEACODIGO IN NUMBER,
    NMDEAPADRE OUT NUMBER,
    NMAZCODIGO OUT NUMBER,
    VCESTADO_PROCESO OUT VARCHAR2,
    VCMENSAJE_PROCESO OUT VARCHAR2
) IS BEGIN
SELECT
    DEA_CODIGO,
    AZD_CODIGO_CLI 
    INTO NMDEAPADRE,NMAZCODIGO
FROM
    (
        WITH CARPETA_PADRE AS (
            SELECT
                D1.TXP_CODIGO
            FROM
                ADM.DATA_ERP_AZ D1
            WHERE
                D1.DEA_CODIGO = NMDEACODIGO
        ),
        ELEMENTOS_HIJO AS (
            SELECT
                *
            FROM
                ADM.DATA_ERP_AZ D2
                INNER JOIN ADM.TAXONOMIA_PARAM TAX ON TAX.TXP_CODIGO = D2.TXP_CODIGO
                INNER JOIN CARPETA_PADRE CP ON TAX.TXP_CODIGO_REF = CP.TXP_CODIGO
        )
        SELECT
            HJ.DEA_CODIGO,
            AZ.AZD_CODIGO_CLI
        FROM
            ELEMENTOS_HIJO HJ,
            ADM.AZ_DIGITAL AZ
        WHERE
            AZ.AZD_CODIGO = HJ.AZD_CODIGO
            AND HJ.TXP_DESCRIPCION = NDESCRIP
    );

VCESTADO_PROCESO := 'S';
VCMENSAJE_PROCESO := 'Procedimiento ejecutado exitosamente';

EXCEPTION
WHEN OTHERS THEN VCESTADO_PROCESO := 'N';

VCMENSAJE_PROCESO := 'ERROR no controlado en RHU.QB_APLICATION_JRHU0055.PL_BUSCAR_TAXONOMIA_INCAPACIDAD, causada por: 
            ' || SQLERRM || ' -- Linea: ' || dbms_utility.format_error_backtrace();

END PL_BUSCAR_TAX_INCA_INTER;

PROCEDURE PL_OBTENER_ENFERMEDAD(
    RSGPENFER OUT REFCURSOR,
    VCESTADO_PROCESO OUT VARCHAR2,
    VCMENSAJE_PROCESO OUT VARCHAR2
) IS BEGIN OPEN RSGPENFER FOR
SELECT
    ENF_COD,
    ENF_NOMBRE,
    GEN_COD,
    SEN_COD
FROM
    PAR.ENFERMEDAD
WHERE
    ROWNUM < 20
ORDER BY
    1;

VCESTADO_PROCESO := 'S';

VCMENSAJE_PROCESO := 'Procedimiento ejecutado exitosamente';

EXCEPTION
WHEN OTHERS THEN VCESTADO_PROCESO := 'N';

VCMENSAJE_PROCESO := 'ERROR no controlado en RHU.QB_APLICATION_JRHU0055.PL_OBTENER_ENFERMEDAD, causada por: 
            ' || SQLERRM || ' -- Linea: ' || dbms_utility.format_error_backtrace();

END PL_OBTENER_ENFERMEDAD;

PROCEDURE PL_CREAR_RADICADO(
   VCTDOCUMENTO IN VARCHAR2,
    NMDOCUMENTO IN NUMBER,
    NMEMPPRINCIPAL IN NUMBER,
    VCTIPODOCEMPR IN VARCHAR2,
    NMCONTRATO IN NUMBER,
    NMCODGENFE IN NUMBER,
    NMCODSGENFE IN NUMBER,
    VCCODENFER IN VARCHAR2,
    NMCONTINCA IN NUMBER,
    VCFECINCIDENTE IN VARCHAR2,
    VCFECINICIOINCA IN VARCHAR2,
    NMDIAS IN NUMBER,
    VCPRORROGA IN VARCHAR2,
    NMIDUSUARIO IN NUMBER ,
    NMSUBCONTI IN NUMBER,
    NMIPUSUARIO IN VARCHAR,
    VCFECHFUERMATE IN VARCHAR2,
    NMRADICADO OUT NUMBER,
    VCESTADO_PROCESO OUT VARCHAR2,
    VCMENSAJE_PROCESO OUT VARCHAR2

) IS 

VCTIPOINCAPACIDAD VARCHAR2(2000);
RDOCUMENSUBTIPO REFCURSOR;
VCESTADO_RESULT VARCHAR2(15);
VCMENSAJE_RESULT VARCHAR2(15);
NMNUMERODOCUMENTO NUMBER;
VCTIPODOCUMENTO VARCHAR(12);
VCPERIODO VARCHAR(12);
VCAPN_PERIODO1 VARCHAR(12);
VCFECHAFINAL VARCHAR2(200);
NMIDENTIFICACIONEPL NUMBER(20);
VCNOMBRECOMPLETO VARCHAR2(200);
VCCORREOEPL VARCHAR(200);
VCMENSAJE VARCHAR(4000);
VCPROCESO VARCHAR(200);
VCURL VARCHAR(200);
VCPARAMETRO VARCHAR(200);
NMPRINCIPAL NUMBER(20);
NMSECUENCIA NUMBER(20);



CURSOR CUR_DOCU_SUBT IS
SELECT
     SBDC.TPD_CODIGO,SBDC.SUD_REQUERIDO
FROM
    RHU.SBT_INCAPACIDAD SINC,
    RHU.SUD_DOCUMENTOS SBDC,
    adm.tipo_documento TPDO
WHERE
    SBDC.SBT_CODIGO = SINC.SBT_CODIGO
    AND TPDO.TPD_CODIGO = SBDC.TPD_CODIGO
    AND SINC.SBT_CODIGO = NMSUBCONTI
    AND SBDC.SUD_ESTADO = 'ACTIVO';

BEGIN 
VCFECHAFINAL:=(TO_DATE(VCFECINICIOINCA,'dd/mm/yyyy') + NMDIAS)-1;

-- SE CALCULA EL PERIODO PARA EL CUAL SE VA REALIZAR LA RADICACION.
VCPERIODO := TO_CHAR(TRUNC(SYSDATE,'MM')-1,'YYYYMM'); -- Pendiente por revisar esta fallando la funcionalidad.
   IF NMCONTINCA = 1 THEN 
       ---HQB--SE DEVUELVE DOS PERIODO
       VCAPN_PERIODO1 :=TO_CHAR(TO_DATE(VCPERIODO||'01','YYYYMMDD')-1,'YYYYMM');
      VCPERIODO:=VCAPN_PERIODO1;
   END IF;


-- SE VALIDA LA CONTIGENCIA PARA DETERMINAR EL RESPONSABLE DE LA INCAPACIDAD.
IF NMCONTINCA > 2 THEN
VCTIPOINCAPACIDAD := 'ARP';
ELSE
VCTIPOINCAPACIDAD := 'EPS';
END IF;


-- SE CONSULTA LA IPS O ARP LA CUAL ES RESPONSABLE DE LA INCAPACIDAD; 
SELECT A.TDC_TD_ENT , A.EMP_ND_ENT
         INTO VCTIPODOCUMENTO,NMNUMERODOCUMENTO
 	     FROM RHU.EPLREGCOB A, PAR.EMPRESA E 
 	      WHERE  E.TDC_TD = A.TDC_TD_ENT 
 	      AND E.EMP_ND = A.EMP_ND_ENT 
          AND A.TDC_TD = VCTDOCUMENTO
          AND A.EPL_ND = NMDOCUMENTO
          AND A.TEN_SIGLA =VCTIPOINCAPACIDAD
          AND A.ERC_VIGENTE ='S';

INSERT INTO
    RHU.INCAPACIDAD (
        TEN_SIGLA,
        TDC_TD,
        EMP_ND,
        INC_SERIE,
        INC_NUMERO,
        TDC_TD_EPL,
        EPL_ND,
        TDC_TD_PAL,
        EMP_ND_PAL,
        CTO_NUMERO,
        INC_FECEXP,
        TEN_SIGLA_IPS,
        TDC_TD_IPS,
        EMP_ND_IPS,
        INC_TIPO,
        GEN_COD,
        SEN_COD,
        ENF_COD,
        INC_CONTIN,
        INC_FECACC,
        INC_FECINI,
        INC_DIAS,
        INC_FECFIN,
        INC_PRORRO,
        INC_DIAPAG,
        INC_BASE,
        INC_VALOR,
        INC_FECEST,
        PRO_CODIGO,
        INC_USUARIO,
        INC_FECHA,
        INC_ESTADO,
        INC_USUARIO_CREA,
        INC_PRIORIDAD,
        INC_VERSION,
        INC_FECHA_CREACION,
        INC_PERIODO,
        INC_FECFUERO_MAT,
        SUBTIPOINC_CODIGO)
VALUES (
        VCTIPOINCAPACIDAD,
        VCTIPODOCUMENTO,
        NMNUMERODOCUMENTO,
        'T',
        SEQ_INC_NUMERO.Nextval, 
        VCTDOCUMENTO,
        NMDOCUMENTO,
        VCTIPODOCEMPR,
        NMEMPPRINCIPAL,
        NMCONTRATO,
        SYSDATE,
        'IPS',
        VCTIPODOCUMENTO,
        NMNUMERODOCUMENTO,
        'A',
        NMCODGENFE,
        NMCODSGENFE,
        VCCODENFER,
        NMCONTINCA,
        VCFECINCIDENTE,
        TO_DATE(VCFECINICIOINCA,'dd/mm/yyyy'),
        NMDIAS,
        VCFECHAFINAL,
        VCPRORROGA,
        0,
        0,
        0,
        SYSDATE,
        1,
        NMIDUSUARIO,
        SYSDATE,
        'CPT',
        NMDOCUMENTO,
        50,
        2,
        SYSDATE,
        VCPERIODO,
        TO_DATE(VCFECHFUERMATE,'dd/mm/yyyy'),
        NMSUBCONTI
        )
        returning INC_RADICACION into NMRADICADO;     

     -- INSERT TABLA PAR.EMPLEADO_TERMINO_CONDICION CONTIENE LA INFORMACION SI EL USUARIO ACEPTO TERMINOS Y CONDICIONES   
     INSERT INTO PAR.EMPLEADO_TERMINO_CONDICION (TER_CODIGO,
                                                 TER_TABLA,
                                                 TER_COLUMNA_PK,
                                                 TER_VALOR_PK,
                                                 TER_ACEPTA_TERMINO,
                                                 TER_IP_USUARIO,
                                                 TDC_TD_EPL,
                                                 EPL_ND,
                                                 AUD_USUARIO,
                                                 AUD_FECHA)
                                         VALUES ( 1,
                                                 'INCAPACIDAD',
                                                 'INC_RADICACION',
                                                  NMRADICADO,
                                                 'S',
                                                  NMIPUSUARIO,
                                                  VCTDOCUMENTO,
                                                  NMDOCUMENTO,
                                                  NMDOCUMENTO,
                                                  SYSDATE);


     -- INSERT DE LA TABLA INSERT_RADICACION_DOCUMENT LA CUAL CONTIENE LOS DOCUMENTOS POR RADICADO.
     FOR i IN CUR_DOCU_SUBT LOOP
        PL_INSERT_RADICACION_DOCUMENT(NMRADICADO,i.TPD_CODIGO,i.SUD_REQUERIDO);
     END LOOP;

    -- NOTIFICACION USUARIO VIA EMAIL.

    -- Buscamos la informacion del empleado para poder notificarlo.
SELECT INC.EPL_ND NUMERO_DOCUMENTO, 
               (SELECT USUARIO_MAIL FROM USUARIO
				WHERE TIPO_DOCUMENTO = INC.TDC_TD_EPL
				AND NUMERO_DOCUMENTO = INC.EPL_ND) EMAIL,
                RHU.FB_EMPLEADO_COLUMNA(INC.TDC_TD_EPL,INC.EPL_ND,'NOMBRE') NOMBRE_COMPLETO,
               (SELECT FB_NOM_EMPRESA(TDC_TD_FIL, EMP_ND_FIL)  
FROM CONTRATO WHERE CTO_NUMERO = INC.CTO_NUMERO AND
 INC.TDC_TD =TDC_TD  AND INC.EMP_ND =EMP_ND) PRINCIPAL
INTO NMIDENTIFICACIONEPL,VCCORREOEPL,VCNOMBRECOMPLETO, NMPRINCIPAL        
FROM RHU.INCAPACIDAD INC WHERE INC_RADICACION=NMRADICADO;

VCPARAMETRO:=fb_constante_car('URL_SITIO',sysdate,'NI',NMPRINCIPAL,NULL,NULL,NULL,NULL);
VCURL:='https://apps.genialw.com/SitioTrabajador/';
RHU.QB_APLICATION_JRHU0055.PL_NOTIFICACION(
   VCCORREOEPL,
    'auxincapacidades3@activos.com.co',
   'Â¡Hemos recibido tu radicacion!' || NMIDENTIFICACIONEPL || ' / ' || NMRADICADO,
    '<div style="text-align: center;">
    <h1>Â¡Ya tenemos respuesta de tu caso!</h1>
    <p>Nombre de la persona: <strong>'|| VCNOMBRECOMPLETO ||'</strong></p>
    <p>ID de la radicacion: <strong>'|| NMRADICADO ||'</strong></p>
    <p>Ya puedes hacerle seguimiento en nuestro portal del trabajador.</p>
    <button style="background-color: #f2a325; border: none; color: white; padding: 10px 20px; border-radius: 5px;">
    <i class="fa fa-search"></i> <a href="'||VCURL||VCPARAMETRO||'" target="_blank"> Consultalo aquiÂ­</a> 
    </button>
    </div>',
   VCPROCESO,
   VCESTADO_PROCESO,
   VCMENSAJE_PROCESO);


SELECT  NVL(max(obs_secuencia),0)+1 
INTO  NMSECUENCIA
FROM observacion_incapacidad 
WHERE INC_RADICACION=NMRADICADO ;
--INSERT EN LA TABLA observacion_incapacidad PARA REALIZAR LA HOMOLOGACION DE ESTADOS CON EL APLICATIVO INCAPACIDADES.
  INSERT INTO 
   OBSERVACION_INCAPACIDAD (
    INC_RADICACION,
    OBS_SECUENCIA,
    OBS_DESCRIPCION,
    OBS_USUARIO,
    OBS_FECHA,
    OBS_ESTADO
   )VALUES(
    NMRADICADO,
    NMSECUENCIA,
    null,
    user,
    sysdate,
    'EN CAPTURA'
   );

 COMMIT;

 VCESTADO_PROCESO := 'S';
 VCMENSAJE_PROCESO := 'Procedimiento ejecutado exitosamente';

EXCEPTION
WHEN NO_DATA_FOUND THEN
VCESTADO_PROCESO := 'N';
 VCMENSAJE_PROCESO := 'No se puede realizar el radicado debido a : ' || SQLERRM || ' -- Linea: ' || dbms_utility.format_error_backtrace();

WHEN OTHERS THEN 
VCESTADO_PROCESO := 'N';
VCMENSAJE_PROCESO := 'ERROR no controlado en RHU.QB_APLICATION_JRHU0055.PL_CREAR_RADICADO, causada por: 
            ' || SQLERRM || ' -- Linea: ' || dbms_utility.format_error_backtrace();

END PL_CREAR_RADICADO;

PROCEDURE PL_INSERT_RADICACION_DOCUMENT(
    NMRADICADO IN NUMBER,
    NMTPD_CODIGO IN NUMBER,
    VCREQUERIDO IN VARCHAR2
) IS
 BEGIN
INSERT INTO
    RHU.RAD_DOCUMENTOS (
        RAD_CODIGO,
        INC_RADICACION,
        TPD_CODIGO,
        RAD_REQUERIDO,
        AUD_USUARIO,
        AUD_FECHA
    )
VALUES
    (
        SEQ_RAD_DOCUMENTOS.Nextval,
        NMRADICADO,
        NMTPD_CODIGO,
        VCREQUERIDO,
        USER,
        SYSDATE
    );
     COMMIT;

EXCEPTION
WHEN OTHERS THEN raise_application_error(
    -20001,
    'ERROR no controlado en 
     RHU.QB_APLICATION_JRHU0055.PL_INSERT_RADICACION_DOCUMENT, causada por: ' || SQLERRM || ' -- Linea: ' || dbms_utility.format_error_backtrace()
);

END PL_INSERT_RADICACION_DOCUMENT;

PROCEDURE PL_OBTENER_TERMINOSYCOND(
    RTERMINO OUT REFCURSOR,
    VCESTADO_PROCESO OUT VARCHAR2,
    VCMENSAJE_PROCESO OUT VARCHAR2
) IS
BEGIN
 OPEN RTERMINO FOR
 SELECT * 
 FROM PAR.TERMINO_CONDICION
 WHERE TER_CODIGO = 1;

VCESTADO_PROCESO := 'S';
VCMENSAJE_PROCESO := 'Procedimiento ejecutado exitosamente';


EXCEPTION
WHEN OTHERS THEN raise_application_error(
    -20001,
    'ERROR no controlado en 
     RHU.QB_APLICATION_JRHU0055.PL_OBTENER_TERMINOSYCOND, causada por: ' || SQLERRM || ' -- Linea: ' || dbms_utility.format_error_backtrace()
);
END PL_OBTENER_TERMINOSYCOND;


PROCEDURE PL_ACTUALIZAR_DOCUMENTO(
    NMDEACODIGO IN NUMBER,
    NMRADICADO  IN NUMBER,
    NMDOCUMENTO IN NUMBER,
    VCESTADO_PROCESO OUT VARCHAR2,
    VCMENSAJE_PROCESO OUT VARCHAR2
)IS
BEGIN
 UPDATE RHU.RAD_DOCUMENTOS 
 SET DEA_CODIGO = NMDEACODIGO 
 WHERE INC_RADICACION=NMRADICADO
 AND TPD_CODIGO = NMDOCUMENTO;
COMMIT;

VCESTADO_PROCESO := 'S';
VCMENSAJE_PROCESO := 'Procedimiento ejecutado exitosamente';

EXCEPTION
WHEN OTHERS THEN raise_application_error(
    -20001,
    'ERROR no controlado en 
     RHU.QB_APLICATION_JRHU0055.PL_ACTUALIZAR_DOCUMENTO, causada por: ' || SQLERRM || ' -- Linea: ' || dbms_utility.format_error_backtrace()
);

END PL_ACTUALIZAR_DOCUMENTO;

PROCEDURE PL_LISTAR_DOCUMENTOS(
    VCIPCLIENTE IN VARCHAR2,
    NMRADICADO IN NUMBER,
    RCDOCUMENTOS OUT REFCURSOR,
    VCESTADO_PROCESO OUT VARCHAR2,
    VCMENSAJE_PROCESO OUT VARCHAR2

)IS
BEGIN
OPEN RCDOCUMENTOS FOR
SELECT    TD2.TPD_CODIGO CODIGO_DOCUMENTO
         ,TD2.TPD_DESCRIPCION NOMBRE_DOCUMENTO
         ,LD.RAD_ESTADO ESTADO_DOCUMENTO
         ,LD.RAD_REQUERIDO REQUERIDO
         ,LD.RAD_OBSERVACIONES OBSERVACION
         ,NVL(AZD.AZD_CODIGO_CLI,0) AZCODIGO
         ,adm.QB_DATOS_TAXONOMIA.fl_url_obtener_documento_az(LD.AUD_USUARIO,VCIPCLIENTE,AZD.AZD_CODIGO_CLI) RUTA
     FROM RHU.RAD_DOCUMENTOS LD
     LEFT JOIN ADM.DATA_ERP_AZ DEA ON LD.DEA_CODIGO = DEA.DEA_CODIGO
     LEFT JOIN ADM.PROPIEDADES_DOCUMENTO PD ON PD.PRD_CODIGO = DEA.PRD_CODIGO
     LEFT JOIN ADM.TIPO_DOCUMENTO TD ON TD.TPD_CODIGO = PD.TPD_CODIGO
     LEFT JOIN ADM.AZ_DIGITAL AZD ON AZD.AZD_CODIGO = DEA.AZD_CODIGO
     LEFT JOIN ADM.TIPO_DOCUMENTO TD2 ON TD2.TPD_CODIGO = LD.TPD_CODIGO
WHERE LD.INC_RADICACION = NMRADICADO;

VCESTADO_PROCESO := 'S';
VCMENSAJE_PROCESO := 'Procedimiento ejecutado exitosamente';

EXCEPTION
WHEN OTHERS THEN raise_application_error(
    -20001,
    'ERROR no controlado en 
     RHU.QB_APLICATION_JRHU0055.PL_LISTAR_DOCUMENTOS, causada por: ' || SQLERRM || ' -- Linea: ' || dbms_utility.format_error_backtrace()
);

END PL_LISTAR_DOCUMENTOS;

PROCEDURE PL_ACTUALIZAR_ESTADO_OBS(
    NMRADICADO IN NUMBER,
    NMDOCUMENTO IN NUMBER,
    VCOBSERVACION IN VARCHAR2 ,
    VCESTADO IN VARCHAR2,
    VCESTADO_PROCESO OUT VARCHAR2,
    VCMENSAJE_PROCESO OUT VARCHAR2
) IS

VCOBSERVACIONF VARCHAR2(200);
BEGIN

 IF VCOBSERVACION IS NULL THEN
   UPDATE RHU.RAD_DOCUMENTOS 
   SET RAD_ESTADO = VCESTADO 
   WHERE INC_RADICACION=NMRADICADO
   AND TPD_CODIGO = NMDOCUMENTO;
ELSE 
   UPDATE RHU.RAD_DOCUMENTOS 
   SET RAD_ESTADO = VCESTADO ,
   RAD_OBSERVACIONES =VCOBSERVACION
   WHERE INC_RADICACION=NMRADICADO
   AND TPD_CODIGO = NMDOCUMENTO;
END IF;

COMMIT;

VCESTADO_PROCESO := 'S';
VCMENSAJE_PROCESO := 'Procedimiento ejecutado exitosamente';

EXCEPTION

WHEN OTHERS THEN 
 VCESTADO_PROCESO := 'N';
raise_application_error(
    -20001,
    'ERROR no controlado en 
     RHU.QB_APLICATION_JRHU0055.PL_ACTUALIZAR_ESTADO_OBS, causada por: ' || SQLERRM || ' -- Linea: ' || dbms_utility.format_error_backtrace());
END PL_ACTUALIZAR_ESTADO_OBS;


PROCEDURE PL_VALIDACION_RADICADO(
    VCFECHAINICIO  IN VARCHAR2,
    NMDOCUMENTOEPL IN NUMBER,
    NMCONTRATO IN NUMBER,
    NMNUMERODIAS IN NUMBER,
    VCTIPDOCUMEEPL IN VARCHAR2,
    NMDOCUMENTOPAL IN NUMBER,
    VCTIPODOCUMPAL IN VARCHAR2,
    VCESTADO_PROCESO OUT VARCHAR2,
    VCMENSAJE_PROCESO OUT VARCHAR2
)IS
VCRETIRO VARCHAR2(200);
VCFECHAFINAL VARCHAR2(200);
VCFECINI VARCHAR(20);
VCFECFIN VARCHAR2(20);
EXRETIRO EXCEPTION;
EXINCAPACTIVA EXCEPTION;
NMREGISTRO NUMBER(10);
BEGIN

VCFECHAFINAL:=(TO_DATE(VCFECHAINICIO,'dd/mm/yyyy') + NMNUMERODIAS)-1;

--PERMITE VALIDAR SI LA FECHA FINAL DE RADICACION ES MAYOR A LA FECHA DE TERMININACION DE CONTRATO O RETIRO.
BEGIN
  BEGIN
   SELECT CTO_FECRET
   INTO VCRETIRO 
   FROM CONTRATO CTO , CTORETIRO CTR
   WHERE CTO.CTO_NUMERO = CTR.CTO_NUMERO
   AND CTR.CTO_NUMERO=NMCONTRATO
   AND CTO.TDC_TD  = VCTIPDOCUMEEPL
   AND CTO.EMP_ND  = NMDOCUMENTOPAL;
  IF  TO_DATE(VCFECHAFINAL,'DD/MM/YYYY') > TO_DATE(VCRETIRO,'DD/MM/YYYY') THEN
    RAISE EXRETIRO;
   END IF;    
  END;

  --PERMITE VALIDAR SI EXISTE UNA RADICACION EN EL SISTEMA YA RADICA EN EL MISMO INTERVALO DE TIEMPO
  BEGIN
  SELECT COUNT(EPL_ND), INC_FECINI, INC_FECFIN 
  INTO NMREGISTRO,VCFECINI, VCFECFIN
  FROM INCAPACIDAD 
  WHERE EPL_ND = NMDOCUMENTOEPL
  AND TDC_TD_EPL = VCTIPDOCUMEEPL
  AND TDC_TD_PAL = VCTIPODOCUMPAL
  AND EMP_ND_PAL = NMDOCUMENTOPAL
  AND CTO_NUMERO = NMCONTRATO
  AND VCFECHAINICIO 
  BETWEEN INC_FECINI AND INC_FECFIN
  GROUP BY (INC_FECINI,INC_FECFIN);
  IF NMREGISTRO > 0 THEN
     RAISE EXINCAPACTIVA;
  END IF;
  END;

  VCESTADO_PROCESO := 'S';
  VCMENSAJE_PROCESO := 'PROCEDIMIENTO EJECUTADO EXITOSAMENTE';

EXCEPTION

WHEN NO_DATA_FOUND THEN
       VCESTADO_PROCESO := 'S';
       VCMENSAJE_PROCESO := 'PROCEDIMIENTO EJECUTADO EXITOSAMENTE';

WHEN EXINCAPACTIVA THEN 
        VCESTADO_PROCESO := 'N';
        VCMENSAJE_PROCESO := 'NO SE PUEDE REALIZAR LA RADICACION DEBIDO A QUE YA SE ENCUENTRA UN RADICACION ACTIVA EN EL RAGO DE FECHA PARA : '|| VCFECINI || ' - ' || VCFECFIN;

WHEN EXRETIRO THEN 
     VCESTADO_PROCESO := 'N';
     VCMENSAJE_PROCESO := 'NO SE PUEDE REALIZAR LA RADICACION DEBIDO A QUE LA FECHA DE FINALIZACION O RETIRO ES MENOR A LA FECHA FINAL DE LA INCAPACIDAD';     



WHEN OTHERS THEN 
VCESTADO_PROCESO := 'N';
VCMENSAJE_PROCESO := 'ERROR NO CONTROLADO EN RHU.QB_APLICATION_JRHU0055.PL_VALIDACION_RADICADO, CAUSADA POR: 
            ' || SQLERRM || ' -- LINEA: ' || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE();
END;
END PL_VALIDACION_RADICADO;

PROCEDURE PL_VALIDAR_TAXRADICADO(
    NMRADICADO IN VARCHAR2,
    VCFLUJO IN VARCHAR,
    NMDEAPADRE OUT NUMBER,
    NMAZCODIGO OUT NUMBER,
    VCESTADO_PROCESO OUT VARCHAR2,
    VCMENSAJE_PROCESO OUT VARCHAR2

)IS
BEGIN
SELECT 
DEA_CODIGO , AZD_CODIGO_CLI 
INTO NMDEAPADRE,NMAZCODIGO
FROM(
    WITH CARPETA_RADICADO AS(
        SELECT TAX.TXP_CODIGO
        FROM ADM.TAXONOMIA_PARAM TAX
        WHERE TIP_FLUJO =VCFLUJO
        AND TXP_DESCRIPCION = NMRADICADO
    ),
    CARPETA_PADRE AS(
          SELECT
                D1.DEA_CODIGO , AZ.AZD_CODIGO_CLI
            FROM
                ADM.DATA_ERP_AZ D1
            INNER JOIN CARPETA_RADICADO CR ON CR.TXP_CODIGO = D1.TXP_CODIGO
            INNER JOIN ADM.AZ_DIGITAL AZ  ON AZ.AZD_CODIGO =D1.AZD_CODIGO
    )
      SELECT
           *
        FROM
            CARPETA_PADRE CP

);

VCESTADO_PROCESO := 'S';
VCMENSAJE_PROCESO := 'Procedimiento ejecutado exitosamente';

EXCEPTION
WHEN OTHERS THEN VCESTADO_PROCESO := 'N';

VCMENSAJE_PROCESO := 'ERROR no controlado en RHU.QB_APLICATION_JRHU0055.PL_BUSCAR_TAXONOMIA_INCAPACIDAD, causada por: 
            ' || SQLERRM || ' -- Linea: ' || dbms_utility.format_error_backtrace();

END PL_VALIDAR_TAXRADICADO;

PROCEDURE PL_ACTUALIZAR_EST_RADICADO(
    NMRADICADO IN NUMBER,
    VCESTADO IN VARCHAR,
    VCESTADO_PROCESO OUT VARCHAR2,
    VCMENSAJE_PROCESO OUT VARCHAR2
)IS
NMIDENTIFICACIONEPL NUMBER(20);
VCNOMBRECOMPLETO VARCHAR2(200);
VCCORREOEPL VARCHAR(200);
VCMENSAJE VARCHAR(4000);
VCPROCESO VARCHAR(200);
VCURL VARCHAR(200);
VCPARAMETRO VARCHAR(200);
NMPRINCIPAL NUMBER(20);

BEGIN
UPDATE RHU.INCAPACIDAD 
SET INC_ESTADO = VCESTADO
WHERE INC_RADICACION = NMRADICADO;
COMMIT;


-- Buscamos la informacion del empleado para poder notificarlo.
SELECT INC.EPL_ND NUMERO_DOCUMENTO, 
               (SELECT USUARIO_MAIL FROM USUARIO
				WHERE TIPO_DOCUMENTO = INC.TDC_TD_EPL
				AND NUMERO_DOCUMENTO = INC.EPL_ND) EMAIL,
                RHU.FB_EMPLEADO_COLUMNA(INC.TDC_TD_EPL,INC.EPL_ND,'NOMBRE') NOMBRE_COMPLETO,
               (SELECT EMP_ND FROM contrato  WHERE CTO_NUMERO = INC.CTO_NUMERO 
AND EPL_ND = INC.EPL_ND 
AND INC.TDC_TD_EPL=TDC_TD_EPL

               ) PRINCIPAL
INTO NMIDENTIFICACIONEPL,VCCORREOEPL,VCNOMBRECOMPLETO, NMPRINCIPAL        
FROM RHU.INCAPACIDAD INC WHERE INC_RADICACION=NMRADICADO;

VCPARAMETRO:=fb_constante_car('URL_SITIO',sysdate,'NI',NMPRINCIPAL,NULL,NULL,NULL,NULL);

VCURL:='https://apps.genialw.com/SitioTrabajador/';

IF VCESTADO = 'DEV' THEN
RHU.QB_APLICATION_JRHU0055.PL_NOTIFICACION(
   VCCORREOEPL,
    'auxincapacidades3@activos.com.co',
   'Â¡Ya tenemos respuesta de tu caso!' || NMIDENTIFICACIONEPL || ' / ' || NMRADICADO,
    '<div style="text-align: center;">
    <h1>Â¡Ya tenemos respuesta de tu caso!</h1>
    <p>Nombre de la persona: <strong>'|| VCNOMBRECOMPLETO ||'</strong></p>
    <p>ID de la radicacion: <strong>'|| NMRADICADO ||'</strong></p>
    <p>Ya puedes hacerle seguimiento en nuestro portal del trabajador.</p>
    <button style="background-color: #f2a325; border: none; color: white; padding: 10px 20px; border-radius: 5px;">
    <i class="fa fa-search"></i> <a href="'||VCURL||VCPARAMETRO||'" target="_blank"> Consultalo aquiÂ­</a> 
    </button>
    </div>',
   VCPROCESO,
   VCESTADO_PROCESO,
   VCMENSAJE_PROCESO);
END IF;
IF VCESTADO = 'CPT' THEN
RHU.QB_APLICATION_JRHU0055.PL_NOTIFICACION(
   VCCORREOEPL,
    'auxincapacidades3@activos.com.co',
   'Â¡Hemos recibido tu radicacion!' || NMIDENTIFICACIONEPL || ' / ' || NMRADICADO,
    '<div style="text-align: center;">
    <h1>Â¡Ya tenemos respuesta de tu caso!</h1>
    <p>Nombre de la persona: <strong>'|| VCNOMBRECOMPLETO ||'</strong></p>
    <p>ID de la radicacion: <strong>'|| NMRADICADO ||'</strong></p>
    <p>Ya puedes hacerle seguimiento en nuestro portal del trabajador.</p>
    <button style="background-color: #f2a325; border: none; color: white; padding: 10px 20px; border-radius: 5px;">
    <i class="fa fa-search"></i> <a href="'||VCURL||VCPARAMETRO||'" target="_blank"> Consultalo aquiÂ­</a> 
    </button>
    </div>',
   VCPROCESO,
   VCESTADO_PROCESO,
   VCMENSAJE_PROCESO);
END IF;


VCESTADO_PROCESO := 'S';
VCMENSAJE_PROCESO := 'Procedimiento ejecutado exitosamente';

EXCEPTION
WHEN NO_DATA_FOUND THEN
 VCESTADO_PROCESO := 'N';
 VCMENSAJE_PROCESO := 'No se puede actualizar el radicado debido a que no existe';

WHEN OTHERS THEN 
 VCESTADO_PROCESO := 'N';
raise_application_error(
    -20001,
    'ERROR no controlado en 
     RHU.QB_APLICATION_JRHU0055.PL_ACTUALIZAR_EST_RADICADO,
     causada por: ' || SQLERRM || ' -- Linea: ' || dbms_utility.format_error_backtrace());

END PL_ACTUALIZAR_EST_RADICADO;


PROCEDURE PL_OBTENER_INCAPACIDADES_CPT(
    RCINC OUT REFCURSOR,
    VCESTADO_PROCESO OUT VARCHAR2,
    VCMENSAJE_PROCESO OUT VARCHAR2
)IS
BEGIN
OPEN RCINC FOR
SELECT DISTINCT(INC.INC_RADICACION),
INC.*,
TINC.TIP_NOMBRE,SINC.SBT_NOMBRE,
RHU.FB_EMPLEADO_COLUMNA(INC.TDC_TD_EPL,INC.EPL_ND,'NOMBRE') NOMBRE_COMPLETO
,(SELECT FB_NOM_EMPRESA(TDC_TD_FIL, EMP_ND_FIL)  FROM CONTRATO 
WHERE CTO_NUMERO = INC.CTO_NUMERO 
AND EPL_ND = INC.EPL_ND 
AND INC.TDC_TD_EPL=TDC_TD_EPL) NOMBRE_EMPRESA_USUARIA
FROM 
RHU.RAD_DOCUMENTOS RAD , INCAPACIDAD INC ,
RHU.TIP_INCAPACIDAD TINC,  RHU.SBT_INCAPACIDAD SINC
WHERE RAD.INC_RADICACION = INC.INC_RADICACION
AND TINC.TIP_CODIGO=SINC.TIP_CODIGO
AND SINC.SBT_CODIGO = INC.SUBTIPOINC_CODIGO
AND INC.INC_ESTADO ='CPT'
ORDER BY INC.INC_RADICACION DESC;

VCESTADO_PROCESO := 'S';
VCMENSAJE_PROCESO := 'Procedimiento ejecutado exitosamente';

EXCEPTION
WHEN OTHERS THEN 
 VCESTADO_PROCESO := 'N';
raise_application_error(
    -20001,
    'ERROR no controlado en 
     RHU.QB_APLICATION_JRHU0055.PL_OBTENER_INCAPACIDADES_CPT,
     causada por: ' || SQLERRM || ' -- Linea: ' || dbms_utility.format_error_backtrace());

END PL_OBTENER_INCAPACIDADES_CPT;

PROCEDURE PL_CREAR_GERS(
    NMNITEMP IN NUMBER,
    NMDOCUMEPL IN NUMBER,
    VCTIPDOCEMP IN VARCHAR2,
    VCTIDOCEPL IN VARCHAR2,
    NMNUMGERS OUT NUMBER,
    VCESTADO_PROCESO OUT VARCHAR2,
    VCMENSAJE_PROCESO OUT VARCHAR2
)IS
BEGIN 
INSERT INTO GRS_INCIDENCIA(
      GRUPOEMP,
      MESA,
      TIPIFICACION,
      NUMRADICADO,
      DESCRIPCION,
      SERVICIO,
      CANALRECEPCION,
      FECHAREAL,
      FECHARADICACION,
      CANALRESPUESTA,
      PRIORIDAD,
      SUCURSALRESPONSABLE,
      EMPRESAPRINCIPAL,
      ESQUEMA,
      USUARIO,
      COORSERVICIO,
      ASESORSAT,
      ESTADO,
      TDC_TD_EPL,
      EPL_ND,
      ACTIVIDAD,
      ESTADOACT,
      TDC_TD,
      EMP_ND,
      TDC_TD_FIL,
      EMP_ND_FIL,
      SUPERESTADO,
      VERRES1,
      VERRES2,
      NIVELERROR,
      MALTIPIFICADO,
      MALREDACTADO,
      AREA_REGISTRA   
)VALUES (
        1
        ,1
        ,75
        ,SOL.SQ_GRS_NUM.nextval
        ,'ERROR AL CONSUMIR LOS SERVICIOS (AZ_DIGITAL,BUS ACTIVOS) EN EL MODULO DE INCAPACIDADES SITIO DEL TRABAJADOR'
        ,1
        ,1
        ,SYSDATE
        ,SYSDATE
        ,1
        ,1
        ,'BOGOTA-OF.PRINCIPAL'
        ,NMNITEMP
        ,'P'
        , USER
        ,'LJACOB'
        ,'LJACOB'
        ,0
        ,VCTIDOCEPL
        ,NMDOCUMEPL
        ,100
        ,0
        ,VCTIPDOCEMP
        ,NMNITEMP
        ,VCTIPDOCEMP
        ,NMNITEMP
        ,1
        ,0
        ,0
        ,1
        ,'N'
        ,'N'
        ,'TECNOLOGIA IT'
 )
  returning NUMRADICADO INTO NMNUMGERS;
COMMIT;
VCESTADO_PROCESO := 'S';
VCMENSAJE_PROCESO := 'Procedimiento ejecutado exitosamente';
EXCEPTION
WHEN OTHERS THEN 
 VCESTADO_PROCESO := 'N';
raise_application_error(
    -20001,
    'ERROR no controlado en 
     RHU.QB_APLICATION_JRHU0055.GRS_INCIDENCIA,
     causada por: ' || SQLERRM || ' -- Linea: ' || dbms_utility.format_error_backtrace());
END PL_CREAR_GERS;


PROCEDURE PL_NOTIFICACION(
  VCCORREODESTINO IN VARCHAR2,
  VCCOPIACORREO IN VARCHAR2,
  VCASUNTO IN VARCHAR2,
  VCMENSAJE IN VARCHAR2,
  VCPROCESO OUT VARCHAR2,
  VCESTADO_PROCESO OUT VARCHAR2,
  VCMENSAJE_PROCESO OUT VARCHAR2
)IS
VCERROR_ENVIO EXCEPTION;
BEGIN		

REP.PB_ENVIA_X_E_DELIVERY('notificacion@activos.com.co', -- ORIGEN -- modificar a la principal correcta
								  VCCORREODESTINO,	-- DESTINO
								  NULL, -- COPIA
								  VCCOPIACORREO, -- COPIA_OCULTA
								  VCASUNTO,
								  VCMENSAJE,
								  NULL,	-- VCRUTA
								  NULL,	-- VCADJUNTO
								  NULL,	-- VCREPORTE
								  NULL,	-- VCBUZONERROR
								  NULL,	-- NMREQUERIMIENTO
								  USER,
								  VCPROCESO);
    IF VCPROCESO IS NULL THEN
    RAISE VCERROR_ENVIO;
    END IF;

    VCESTADO_PROCESO := 'S';
    VCMENSAJE_PROCESO := 'Procedimiento ejecutado exitosamente';

EXCEPTION
WHEN VCERROR_ENVIO THEN 
VCESTADO_PROCESO := 'N';
VCMENSAJE_PROCESO := 'Error al notificar';

WHEN OTHERS THEN 
 VCESTADO_PROCESO := 'N';
raise_application_error(
    -20001,
    'ERROR no controlado en 
     RHU.QB_APLICATION_JRHU0055.PL_NOTIFICACION,
     causada por: ' || SQLERRM || ' -- Linea: ' || dbms_utility.format_error_backtrace());

END PL_NOTIFICACION;

END QB_APLICATION_JRHU0055;