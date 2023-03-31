/
create or replace PACKAGE     RHU.QB_APLICATION_JRHU0055 AS

--**********************************************************************************************************
--** NOMBRE SCRIPT        : QRHU0299
--** OBJETIVO             : ADMINISTRACION DE GESTOR DE INCAPACIDADES
--** ESQUEMA              : RHU
--** AUTOR                : DEIBY SIERRA
--** FECHA                : 20/02/2023
--**********************************************************************************************************

TYPE REFCURSOR IS REF CURSOR;

PROCEDURE PL_OBTENER_TODAS_INCAPACIDADES(RCINC              OUT REFCURSOR,
                                            VCESTADO_PROCESO   OUT VARCHAR2,
                                            VCMENSAJE_PROCESO  OUT VARCHAR2);

PROCEDURE PL_OBTENER_INC_DEV(RCINCDEV              OUT REFCURSOR,
                                            VCESTADO_PROCESO   OUT VARCHAR2,
                                            VCMENSAJE_PROCESO  OUT VARCHAR2);

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
PROCEDURE PL_OBTENER_TODAS_INCAPACIDADES(RCINC              OUT REFCURSOR,
                                            VCESTADO_PROCESO   OUT VARCHAR2,
                                            VCMENSAJE_PROCESO  OUT VARCHAR2)IS
                         
    BEGIN

        OPEN RCINC FOR
            SELECT * FROM INCAPACIDAD WHERE ROWNUM <= 100;

        VCESTADO_PROCESO := 'S';
        VCMENSAJE_PROCESO := 'Procedimiento ejecutado exitosamente';

    EXCEPTION
        WHEN OTHERS THEN
            VCESTADO_PROCESO := 'N';
            VCMENSAJE_PROCESO := 'ERROR no controlado en RHU.QB_APLICATION_JRHU0055.PL_OBTENER_TODAS_INCAPACIDADES, causada por: '||SQLERRM||' -- Linea: ' || dbms_utility.format_error_backtrace();

END PL_OBTENER_TODAS_INCAPACIDADES;

PROCEDURE PL_OBTENER_INC_DEV(RCINCDEV              OUT REFCURSOR,
                                            VCESTADO_PROCESO   OUT VARCHAR2,
                                            VCMENSAJE_PROCESO  OUT VARCHAR2)IS
                         
    BEGIN

        OPEN RCINCDEV FOR
            SELECT * FROM INCAPACIDAD WHERE INC_ESTADO = 'DEV' AND ROWNUM <= 100;

        VCESTADO_PROCESO := 'S';
        VCMENSAJE_PROCESO := 'Procedimiento ejecutado exitosamente';

    EXCEPTION
        WHEN OTHERS THEN
            VCESTADO_PROCESO := 'N';
            VCMENSAJE_PROCESO := 'ERROR no controlado en RHU.QB_APLICATION_JRHU0055.PL_OBTENER_INC_DEV, causada por: '||SQLERRM||' -- Linea: ' || dbms_utility.format_error_backtrace();

END PL_OBTENER_INC_DEV;

END QB_APLICATION_JRHU0055;