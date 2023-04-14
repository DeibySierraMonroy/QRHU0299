create
or replace PACKAGE RHU.QB_APLICATION_JRHU0055 AS --**********************************************************************************************************
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

END QB_APLICATION_JRHU0055;

/ create
or replace PACKAGE BODY RHU.QB_APLICATION_JRHU0055 AS --**********************************************************************************************************
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

END QB_APLICATION_JRHU0055;