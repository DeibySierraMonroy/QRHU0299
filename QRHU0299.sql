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

PROCEDURE PL_OBTENER_TODAS_INCAPACIDADES(
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

END QB_APLICATION_JRHU0055;

/ 
create or replace PACKAGE BODY RHU.QB_APLICATION_JRHU0055 AS
 --**********************************************************************************************************
--** NOMBRE SCRIPT        : QRHU0299
--** OBJETIVO             : CONTIENE LA ADMINISTRACION DE GESTOR DE INCAPACIDADES
--** ESQUEMA              : RHU
--** AUTOR                : DEIBY SIERRA
--** FECHA                : 20/02/2023
--**********************************************************************************************************
PROCEDURE PL_OBTENER_TODAS_INCAPACIDADES(
    RCINC OUT REFCURSOR,
    VCESTADO_PROCESO OUT VARCHAR2,
    VCMENSAJE_PROCESO OUT VARCHAR2
) IS BEGIN OPEN RCINC FOR
SELECT
    *
FROM
    INCAPACIDAD
WHERE
    ROWNUM <= 100;

VCESTADO_PROCESO := 'S';

VCMENSAJE_PROCESO := 'Procedimiento ejecutado exitosamente';

EXCEPTION
WHEN OTHERS THEN VCESTADO_PROCESO := 'N';

VCMENSAJE_PROCESO := 'ERROR no controlado en RHU.QB_APLICATION_JRHU0055.PL_OBTENER_TODAS_INCAPACIDADES, causada por: 
            ' || SQLERRM || ' -- Linea: ' || dbms_utility.format_error_backtrace();

END PL_OBTENER_TODAS_INCAPACIDADES;

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
    RHU.TIPO_INCAPACIDAD
WHERE
    TIPOINC_ESTADO = 'ACTIVO';

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
    RHU.SUBTIPO_INCAPACIDAD
WHERE
    SUBTIPOINC_ESTADO = 'ACTIVO'
    AND TIPOINC_CODIGO = NTIPOINC;

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
    RHU.SUBTIPO_INCAPACIDAD SINC,
    RHU.SUBTIPO_DOCUMENTOS SBDC,
    adm.tipo_documento TPDO
WHERE
    SBDC.SUBTIPOINC_CODIGO = SINC.SUBTIPOINC_CODIGO
    AND TPDO.TPD_CODIGO = SBDC.TPD_CODIGO
    AND SINC.SUBTIPOINC_CODIGO = NSUBTIPOINC
    AND SBDC.SUDO_ESTADO = 'ACTIVO';

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
    NMIDUSUARIO IN NUMBER,
    NMSUBCONTI IN NUMBER,
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

CURSOR CUR_DOCU_SUBT IS
SELECT
     SBDC.TPD_CODIGO,SBDC.SUDO_REQUERIDO
FROM
    RHU.SUBTIPO_INCAPACIDAD SINC,
    RHU.SUBTIPO_DOCUMENTOS SBDC,
    adm.tipo_documento TPDO
WHERE
    SBDC.SUBTIPOINC_CODIGO = SINC.SUBTIPOINC_CODIGO
    AND TPDO.TPD_CODIGO = SBDC.TPD_CODIGO
    AND SINC.SUBTIPOINC_CODIGO = NMSUBCONTI
    AND SBDC.SUDO_ESTADO = 'ACTIVO';



BEGIN 

-- Se calcula el periodo para el cual se va realizar la radicacion.
VCPERIODO := TO_CHAR(TRUNC(VCFECINICIOINCA,'MM')-1,'YYYYMM');
   IF NMCONTINCA = 1 THEN 
       ---HQB--SE DEVUELVE DOS PERIODO
       VCAPN_PERIODO1 :=TO_CHAR(TO_DATE(VCPERIODO||'01','YYYYMMDD')-1,'YYYYMM');
      VCPERIODO:=VCAPN_PERIODO1;
   END IF;
   

-- Se valida la contigencia para determinar el responsable de la incapacidad.
IF NMCONTINCA > 2 THEN
VCTIPOINCAPACIDAD := 'ARP';
ELSE
VCTIPOINCAPACIDAD := 'EPS';
END IF;


-- Se consulta la IPS o ARP la cual es responsable de la incapacidad; 
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
        SUBTIPOINC_CODIGO)
VALUES (
        VCTIPOINCAPACIDAD,
        VCTIPODOCUMENTO,
        NMNUMERODOCUMENTO,
        'A',
        1122233344,
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
        VCFECINICIOINCA,
        NMDIAS,
        SYSDATE,
        VCPRORROGA,
        0,
        0,
        0,
        SYSDATE,
        0,
        NMIDUSUARIO,
        SYSDATE,
        'CPT',
        USER,
        50,
        2,
        SYSDATE,
        VCPERIODO,
        NMSUBCONTI
        )
        returning INC_RADICACION into NMRADICADO;       
     FOR i IN CUR_DOCU_SUBT LOOP
        PL_INSERT_RADICACION_DOCUMENT(NMRADICADO,i.TPD_CODIGO,i.SUDO_REQUERIDO);
     END LOOP;
 COMMIT;
 
 VCESTADO_PROCESO := 'S';
 VCMENSAJE_PROCESO := 'Procedimiento ejecutado exitosamente';

EXCEPTION
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
    RHU.RADICACION_DOCUMENTOS (
        RADO_CODIGO,
        INC_RADICACION,
        TPD_CODIGO,
        RADO_REQUERIDO,
        AUD_USUARIO,
        AUD_FECHA
    )
VALUES
    (
        SEQ_RADICACION_DOCUMENTOS.Nextval,
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
 UPDATE RHU.RADICACION_DOCUMENTOS 
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


END QB_APLICATION_JRHU0055;
