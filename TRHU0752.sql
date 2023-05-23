/
--*************************************************************************
--** OBJETIVO             : TIPOS DE INCAPACIDAD
--** ESQUEMA              : RHU
--** TABLA                : TIPO_INCAPACIDAD
--** AUTOR                : JARGUMEDO
--** FECHA CREACION       : 2023-03-06
--************************************************************************

--*************************************************************************
--** FORMATO TABLA
--*************************************************************************
CREATE TABLE RHU.TIP_INCAPACIDAD (
    TIP_CODIGO              NUMBER PRIMARY KEY,
    TIP_NOMBRE              VARCHAR2(100) NOT NULL,
    TIP_ESTADO              VARCHAR2(15) NOT NULL,
    AUD_USUARIO             VARCHAR2(15) NOT NULL,
    AUD_FECHA               DATE NOT NULL
);

ALTER TABLE RHU.TIP_INCAPACIDAD ADD CONSTRAINT TIP_ESTADO_C CHECK (TIP_ESTADO IN ('ACTIVO' , 'DESACTIVADO'));
/
--*************************************************************************
--** COMENTARIOS DE LAS COLUMNAS DE LA TABLA, NO EXCEDER LOS 30 CARACTERES.
--*************************************************************************
COMMENT ON TABLE RHU.TIPO_INCAPACIDAD IS
'Tabla para administrar los resgitros de tipo de incapacidades.';

COMMENT ON COLUMN RHU.TIPO_INCAPACIDAD.TIPOINC_CODIGO   IS
'ID del registro de tipo de incapacidad.';

COMMENT ON COLUMN RHU.TIPO_INCAPACIDAD.TIPOINC_NOMBRE   IS
'Nombre del registro de tipo de incapacidad.';

COMMENT ON COLUMN RHU.TIPO_INCAPACIDAD.TIPOINC_ESTADO   IS
'Estado del registro de tipo de incapacidad.';

COMMENT ON COLUMN RHU.TIPO_INCAPACIDAD.AUD_USUARIO   IS
'Nombre de usuario que realiza la accion.';

COMMENT ON COLUMN RHU.TIPO_INCAPACIDAD.AUD_FECHA   IS
'Fecha de usuario que realiza la accion.';

/
--*************************************************************************
--** SE CREA EL SINONIMO DE LA TABLA.
--*************************************************************************
GRANT SELECT ON RHU.TIP_INCAPACIDAD TO PUBLIC;
CREATE PUBLIC SYNONYM TIP_INCAPACIDAD FOR RHU.TIP_INCAPACIDAD;
GRANT ALL ON RHU.TIP_INCAPACIDAD TO PUBLIC;

--*************************************************************************
--** CREACION DE SECUENCIA.
--*************************************************************************
CREATE SEQUENCE RHU.SEQ_TIP_INCAPACIDAD INCREMENT BY 1 MAXVALUE 9999999999999999999999999999 MINVALUE 1 NOCACHE;
GRANT ALL ON RHU.SEQ_TIP_INCAPACIDAD TO PUBLIC;
/
INSERT INTO  RHU.TIP_INCAPACIDAD VALUES (1,'ENFERMEDAD GENERAL','ACTIVO',USER,SYSDATE);
INSERT INTO  RHU.TIP_INCAPACIDAD VALUES (4,'ENFERMEDAD LABORAL','ACTIVO',USER,SYSDATE);
INSERT INTO  RHU.TIP_INCAPACIDAD VALUES (3,'ACCIDENTE LABORAL','ACTIVO',USER,SYSDATE);
INSERT INTO  RHU.TIP_INCAPACIDAD VALUES (2,'LICENCIA MATERNIDAD, ABORTO Y PATERNIDAD','ACTIVO',USER,SYSDATE);

COMMIT;
/