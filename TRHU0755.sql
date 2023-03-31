/
--*************************************************************************
--** OBJETIVO             : CONFIGURACION PARA LA EXTENSION LOS DOCUMENTOS 
--**                        PARA LA RADICACION DE INCAPACIDAD
--** ESQUEMA              : RHU
--** TABLA                : EXTENCION_DOCUMENTO_SUBTIPO
--** AUTOR                : JARGUMEDO
--** FECHA CREACION       : 2023-03-06
--*************************************************************************


--*************************************************************************
--** FORMATO TABLA
--*************************************************************************
CREATE TABLE RHU.EXTENCION_DOCUMENTO_SUBTIPO (
    EXDOCSTIPO_CODIGO               NUMBER PRIMARY KEY,
    DOCINCSUB_CODIGO                NUMBER NOT NULL,
    EXDOCSTIPO_NOMBRE               VARCHAR2(15) NOT NULL,
    EXDOCSTIPO_ESTADO               VARCHAR2(10) NOT NULL,
    AUD_USUARIO                     VARCHAR2(15) NOT NULL,
    AUD_FECHA                       DATE NOT NULL,
);
/

--*************************************************************************
--** RELACION DE LLAVES FORANEAS
--*************************************************************************
ALTER TABLE RHU.EXTENCION_DOCUMENTO_SUBTIPO ADD CONSTRAINT EXDOCSTIPO_ESTADO_C CHECK (EXDOCSTIPO_ESTADO IN ('ACTIVO' , 'DESACTIVADO'));
ALTER TABLE RHU.EXTENCION_DOCUMENTO_SUBTIPO ADD CONSTRAINT EXDOCSTIPO_ESTADO_FK FOREIGN KEY (DOCINCSUB_CODIGO) REFERENCES RHU.DOCUMENTO_INC_SUBTIPO (DOCINCSUB_CODIGO);

/
--*************************************************************************
--** COMENTARIOS DE LAS COLUMNAS DE LA TABLA, NO EXCEDER LOS 30 CARACTERES.
--*************************************************************************
COMMENT ON TABLE RHU.EXTENCION_DOCUMENTO_SUBTIPO IS
'TABLA PARA ADMIN LAS EXTENSIONES DE LOS DOCS DE INC.';

COMMENT ON COLUMN RHU.EXTENCION_DOCUMENTO_SUBTIPO.EXDOCSTIPO_CODIGO   IS
'ID del registro de extension del doc.';

COMMENT ON COLUMN RHU.EXTENCION_DOCUMENTO_SUBTIPO.DOCINCSUB_CODIGO   IS
'Llave foranea para la relacion entre documento inc..';

COMMENT ON COLUMN RHU.EXTENCION_DOCUMENTO_SUBTIPO.EXDOCSTIPO_NOMBRE   IS
'Nombre de la extension del doc.';

COMMENT ON COLUMN RHU.EXTENCION_DOCUMENTO_SUBTIPO.SUBTIPOINC_ESTADO   IS
'Estado de la extension del doc.';

COMMENT ON COLUMN RHU.EXTENCION_DOCUMENTO_SUBTIPO.AUD_USUARIO   IS
'Nombre de usuario que realiza la acción.';

COMMENT ON COLUMN RHU.EXTENCION_DOCUMENTO_SUBTIPO.AUD_FECHA   IS
'Fecha de usuario que realiza la acción.';

/
--*************************************************************************
--** SE CREA EL SINONIMO DE LA TABLA.
--*************************************************************************
GRANT SELECT ON RHU.EXTENCION_DOCUMENTO_SUBTIPO TO PUBLIC;
CREATE PUBLIC SYNONYM EXTENCION_DOCUMENTO_SUBTIPO FOR RHU.EXTENCION_DOCUMENTO_SUBTIPO;
GRANT ALL ON RHU.EXTENCION_DOCUMENTO_SUBTIPO TO PUBLIC;

--*************************************************************************
--** CREACION DE SECUENCIA.
--*************************************************************************
CREATE SEQUENCE RHU.SEQ_EXTENCION_DOCUMENTO_SUBTIPO INCREMENT BY 1 MAXVALUE 9999999999999999999999999999 MINVALUE 1 NOCACHE;
GRANT ALL ON RHU.SEQ_EXTENCION_DOCUMENTO_SUBTIPO TO PUBLIC;

COMMIT;
/