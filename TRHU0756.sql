/
--*************************************************************************
--** OBJETIVO             : CONFIGURACION DE DOCUMENTOS PARA LA RADICACION
--**                        DE INCAPACIDAD
--** ESQUEMA              : RHU
--** TABLA                : INCAPACIDAD_ESTADO
--** AUTOR                : JARGUMEDO
--** FECHA CREACION       : 2023-03-06
--*************************************************************************


--*************************************************************************
--** FORMATO TABLA
--*************************************************************************
CREATE TABLE RHU.INCAPACIDAD_ESTADO (
    INCESTADO_CODIGO                NUMBER PRIMARY KEY,
    INCESTADO_NOMBRE                VARCHAR2(15) NOT NULL,
    INCESTADO_ALIAS                 VARCHAR2(15) NOT NULL,
    AUD_USUARIO                     VARCHAR2(15) NOT NULL,
    AUD_FECHA                       DATE NOT NULL
)
--*************************************************************************
--** COMENTARIOS DE LAS COLUMNAS DE LA TABLA, NO EXCEDER LOS 30 CARACTERES.
--*************************************************************************
COMMENT ON TABLE RHU.INCAPACIDAD_ESTADO IS
'Tabla para administrar estados de incapacidades.';

COMMENT ON COLUMN RHU.INCAPACIDAD_ESTADO.INCESTADO_CODIGO   IS
'ID del registro de estado de incapacidad.';

COMMENT ON COLUMN RHU.INCAPACIDAD_ESTADO.INCESTADO_NOMBRE   IS
'Nombre del estado de incapacidad.';

COMMENT ON COLUMN RHU.INCAPACIDAD_ESTADO.INCESTADO_ALIAS   IS
'Nombre del alias del estado de incapacidad.';

COMMENT ON COLUMN RHU.INCAPACIDAD_ESTADO.AUD_USUARIO   IS
'Nombre de usuario que realiza la acción.';

COMMENT ON COLUMN RHU.INCAPACIDAD_ESTADO.AUD_FECHA   IS
'Fecha de usuario que realiza la acción.';

/
--*************************************************************************
--** SE CREA EL SINONIMO DE LA TABLA.
--*************************************************************************
GRANT SELECT ON RHU.INCAPACIDAD_ESTADO TO PUBLIC;
CREATE PUBLIC SYNONYM INCAPACIDAD_ESTADO FOR RHU.INCAPACIDAD_ESTADO;
GRANT ALL ON RHU.INCAPACIDAD_ESTADO TO PUBLIC;

--*************************************************************************
--** CREACION DE SECUENCIA.
--*************************************************************************
CREATE SEQUENCE RHU.SEQ_INCAPACIDAD_ESTADO INCREMENT BY 1 MAXVALUE 9999999999999999999999999999 MINVALUE 1 NOCACHE;
GRANT ALL ON RHU.SEQ_INCAPACIDAD_ESTADO TO PUBLIC;

COMMIT;
/