/
--*************************************************************************
--** OBJETIVO             : CONFIGURACION DE DOCUMENTOS PARA LA RADICACION
--**                        DE INCAPACIDAD
--** ESQUEMA              : RHU
--** TABLA                : DOCUMENTO_INC_SUBTIPO
--** AUTOR                : JARGUMEDO
--** FECHA CREACION       : 2023-03-06
--*************************************************************************


--*************************************************************************
--** FORMATO TABLA
--*************************************************************************
CREATE TABLE RHU.DOCUMENTO_INC (
    DOCINC_CODIGO                NUMBER PRIMARY KEY,
    DOCINC_PRDCODIGO             VARCHAR2(15) NOT NULL,
    DOCINC_ESTADO                VARCHAR2(10) NOT NULL,
    AUD_USUARIO                     VARCHAR2(15) NOT NULL,
    AUD_FECHA                       DATE NOT NULL
)
/

--*************************************************************************
--** RELACION DE LLAVES FORANEAS
--*************************************************************************
ALTER TABLE RHU.DOCUMENTO_INC ADD CONSTRAINT DOCINCDOCUMENTO_INC CHECK (DOCINC_ESTADO IN ('ACTIVO' , 'DESACTIVADO'));
ALTER TABLE RHU.DOCUMENTO_INC_SUBTIPO ADD CONSTRAINT SUBTIPOINC_CODIGO_FK FOREIGN KEY (SUBTIPOINC_CODIGO) REFERENCES RHU.SUBTIPO_INCAPACIDAD (SUBTIPOINC_CODIGO);

/
--*************************************************************************
--** COMENTARIOS DE LAS COLUMNAS DE LA TABLA, NO EXCEDER LOS 30 CARACTERES.
--*************************************************************************
COMMENT ON TABLE RHU.DOCUMENTO_INC_SUBTIPO IS
'Administrar subtipo de incapacidades';

COMMENT ON COLUMN RHU.DOCUMENTO_INC_SUBTIPO.DOCINCSUB_CODIGO   IS
'ID del registro de documentos.';

COMMENT ON COLUMN RHU.DOCUMENTO_INC_SUBTIPO.SUBTIPOINC_CODIGO   IS
'Llave foranea subtipo incapacidad.';

COMMENT ON COLUMN RHU.DOCUMENTO_INC_SUBTIPO.DOCINCSUB_PRDCODIGO   IS
'Codigo prd del documento.';

COMMENT ON COLUMN RHU.DOCUMENTO_INC_SUBTIPO.DOCINCSUB_ESTADO   IS
'Estado del documento.';

COMMENT ON COLUMN RHU.DOCUMENTO_INC_SUBTIPO.AUD_USUARIO   IS
'Nombre de usuario que realiza la acción.';

COMMENT ON COLUMN RHU.DOCUMENTO_INC_SUBTIPO.AUD_FECHA   IS
'Fecha de usuario que realiza la acción.';

/
--*************************************************************************
--** SE CREA EL SINONIMO DE LA TABLA.
--*************************************************************************
GRANT SELECT ON RHU.DOCUMENTO_INC TO PUBLIC;
CREATE PUBLIC SYNONYM DOCUMENTO_INC_SUBTIPO FOR RHU.DOCUMENTO_INC;
GRANT ALL ON RHU.DOCUMENTO_INC TO PUBLIC;

--*************************************************************************
--** CREACION DE SECUENCIA.
--*************************************************************************
CREATE SEQUENCE RHU.SEQDOCUMENTO_INC INCREMENT BY 1 MAXVALUE 9999999999999999999999999999 MINVALUE 1 NOCACHE;
GRANT ALL ON RHU.DOCUMENTO_INC TO PUBLIC;

COMMIT;
/